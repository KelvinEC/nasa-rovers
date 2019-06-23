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
    weak var view: BBSyncDataOnboardingViewController?
    private let _getManifestsInteractor: BBGetRoverManifestProtocol
    private weak var _coordinator: BBMainCoordinatorProtocol?

    var roversManifests: [BBRoverManifestModel] = [BBRoverManifestModel]()

    init(_ getManifestsInteractor: BBGetRoverManifestProtocol, coordinator: BBMainCoordinatorProtocol)
    {
        self._getManifestsInteractor = getManifestsInteractor
        self._coordinator = coordinator
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
                if let selfBlocked = self {
                    switch result {
                    case .success(let manifest):
                        if let mWrapped = manifest {
                            selfBlocked.roversManifests.append(mWrapped)
                            if selfBlocked.roversManifests.count == BBRoverNameModel.allCases.count {
                                selfBlocked.view?.hideProgress(.success)
                                selfBlocked._coordinator?.roversPhotos(to: selfBlocked.roversManifests)
                            }
                        } else {
                            selfBlocked.view?.showUnknownError()
                        }
                    case .failure(let err):
                        selfBlocked.view?.hideProgress(.dismiss)
                        switch err {
                        case BBNetworkError.noInternetConnection:
                            selfBlocked.view?.showNoInternetConnectionError()
                        default:
                            selfBlocked.view?.showUnknownError()
                        }
                    }
                }
            }
        }
    }
}
