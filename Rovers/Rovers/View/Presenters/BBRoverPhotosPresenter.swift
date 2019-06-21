//
//  BBRoverPhotosPresenter.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBRoverPhotosPresenter
{
    weak var view: BBRoverPhotosViewController?
    private let _roversAvailable = BBRoverNameModel.allCases
    private var _currentSelectedIndex: Int = 0
    private let _getRoverManifestInteractor: BBGetRoverManifest
    private let _getRoverPhotosInteractor: BBGetRoverPhotos
    private var _displayingPhotos: [BBPhotoModel] = [BBPhotoModel]()

    init(roverManifestInteractor: BBGetRoverManifest, roverPhotosInteractor: BBGetRoverPhotos)
    {
        self._getRoverManifestInteractor = roverManifestInteractor
        self._getRoverPhotosInteractor = roverPhotosInteractor
    }

    func viewDidLoad()
    {
        view?.show(rovers: _getRovers())
        getPhotos(for: _roversAvailable[_currentSelectedIndex], date: "2019-06-20")
    }

    func selectedRoverPhoto(index: Int)
    {
        if let vc = view {
            BBNavigator.navigateToPhotoViewer(photo: _displayingPhotos[index], from: vc)
        }
    }

    func selectedRoverChanged(_ index: Int)
    {
        _currentSelectedIndex = index
        getPhotos(for: _roversAvailable[_currentSelectedIndex], date: "2019-06-20")
    }

    private func _getRovers() -> [String]
    {
        return BBRoverNameModel.allCases.map { $0.rawValue }
    }

    func getPhotos(for rover: BBRoverNameModel, date: String)
    {
        _getRoverPhotosInteractor.get(for: rover, date: date) { [weak self] result in
            switch result {
            case .success(let photos):
                if let selfBlocked = self {
                    if rover == selfBlocked._roversAvailable[selfBlocked._currentSelectedIndex] {
                        selfBlocked._displayingPhotos.removeAll()
                        if let pWrapped = photos {
                            selfBlocked._displayingPhotos.append(contentsOf: pWrapped)
                        }

                        DispatchQueue.main.sync {
                            selfBlocked.view?.show(photos: selfBlocked._displayingPhotos)
                            selfBlocked.view?.reloadData()
                        }
                    }
                }
            case .failure(let err): print(err)
            }
        }
    }

    func getManifest(for rover: BBRoverNameModel)
    {
        _getRoverManifestInteractor.getManifest(for: rover) { result in
            switch result {
            case .success(let manifest): break
            case .failure(let err): print(err)
            }
        }
    }
}
