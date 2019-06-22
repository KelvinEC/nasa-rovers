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
    private let _getRoverPhotosInteractor: BBGetRoverPhotos
    private var _displayingPhotos: [BBPhotoModel] = [BBPhotoModel]()
    private let _roversManifests: [BBRoverManifestModel]

    init(_ roverPhotosInteractor: BBGetRoverPhotos, roversManifests: [BBRoverManifestModel])
    {
        self._getRoverPhotosInteractor = roverPhotosInteractor
        self._roversManifests = roversManifests
    }

    func viewDidLoad()
    {
        view?.show(rovers: _getRovers())
        selectedRoverChanged(_currentSelectedIndex)
    }

    func filterByDateTapped()
    {
        let currentRover = _roversAvailable[_currentSelectedIndex]
        if let roverManifest = _roversManifests.first (where: { $0.name == currentRover }) {
            let dates = roverManifest.photos.reduce([], {
                $0.contains($1) ? $0 : $0 + [$1] })
            let datesAsFilters = dates.compactMap { BBDateFilter(serverDate: $0.earthDate) }

            BBNavigator.navigateToFilterByDate(dates: datesAsFilters, delegate: self, from: view!)
        }
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
        let currentRover = _roversAvailable[_currentSelectedIndex]
        if let roverMaxDate = _roversManifests.first(where: {$0.name == currentRover})?.maxDate {
            getPhotos(for: currentRover , date: roverMaxDate)
        }
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
}

extension BBRoverPhotosPresenter: BBFilterByDateProtocol
{
    func selected(filter: String?)
    {
        if let date = filter {
            self._displayingPhotos.removeAll()
            self.view?.show(photos: self._displayingPhotos)
            self.view?.reloadData()
            getPhotos(for: _roversAvailable[_currentSelectedIndex], date: date)
        }
    }
}
