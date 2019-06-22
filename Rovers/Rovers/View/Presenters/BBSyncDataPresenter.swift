//
//  BBSyncDataPresenter.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBSyncDataPresenter
{
    private let _getManifestsInteractor: BBGetRoverManifest
    weak var view: BBSyncDataOnboardingViewController?

    var roversManifests: [BBRoverManifestModel] = [BBRoverManifestModel]()

    init(_ getManifestsInteractor: BBGetRoverManifest)
    {
        self._getManifestsInteractor = getManifestsInteractor
    }
    
    func syncDataTapped()
    {
        view?.showProgress()

        roversManifests.removeAll()
        BBRoverNameModel.allCases.forEach {
            getManifest(for: $0)
        }
    }

    private func getManifest(for rover: BBRoverNameModel)
    {
        _getManifestsInteractor.getManifest(for: rover) { [weak self] result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let manifest):
                    if let mWrapped = manifest {
                        self?.roversManifests.append(mWrapped)
                        if self?.roversManifests.count == BBRoverNameModel.allCases.count {
                            self?.view?.hideProgress(.success)
                            self?.navigateToRoversPhotos()
                        }
                    } else {
                        self?.view?.showUnknownError()
                    }
                case .failure(let err):
                    self?.view?.hideProgress(.dismiss)
                    switch err {
                    case BBNetworkError.noInternetConnection:
                        self?.view?.showNoInternetConnectionError()
                    default:
                        self?.view?.showUnknownError()
                    }
                }
            }
        }
    }

    private func navigateToRoversPhotos()
    {
        BBNavigator.navigateToRoversPhotosViewController(manifests: roversManifests, from: view!)
    }
}
