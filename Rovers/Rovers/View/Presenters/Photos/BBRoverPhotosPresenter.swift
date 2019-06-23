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
    // MARK: - Class dependencies
    weak var view: BBRoverPhotosViewProtocol?
    private weak var _coordinator: BBMainCoordinatorProtocol?
    private let _createDateFiltersInteractor: BBCreateDateFiltersProtocol
    private let _getRoverPhotosInteractor: BBGetRoverPhotosProtocol
    private let _mainQueue = DispatchQueue.main

    // MARK: - Properties
    private let _roversAvailable = BBRoverNameModel.allCases
    private var _currentSelectedIndex: Int = 0
    private var _displayingPhotos: [BBPhotoModel] = [BBPhotoModel]()
    private let _roversManifests: [BBRoverManifestModel]
    private var _currentDate: String = ""

    init(_ roverPhotosInteractor: BBGetRoverPhotosProtocol,
         dateFiltersInteractor: BBCreateDateFiltersProtocol,
         coordinator: BBMainCoordinatorProtocol,
         roversManifests: [BBRoverManifestModel])
    {
        self._createDateFiltersInteractor = dateFiltersInteractor
        self._getRoverPhotosInteractor = roverPhotosInteractor
        self._roversManifests = roversManifests
        self._coordinator = coordinator
    }

    func viewDidLoad()
    {
        view?.show(rovers: _getRovers())
        selectedRoverChanged(_currentSelectedIndex)
    }

    func filterByDateTapped()
    {
        view?.showProgress()
        let currentRover = _roversAvailable[_currentSelectedIndex]
        if let roverManifest = _roversManifests.first (where: { $0.name == currentRover }) {
            _createDateFiltersInteractor.get(roverManifest: roverManifest) { [weak self] dateFilters in
                self?._mainQueue.async {
                    if let selfBlocked = self {
                        selfBlocked.view?.hideProgress(.dismiss)
                        if dateFilters.count > 0, let date =  BBDateFilter( serverDate: selfBlocked._currentDate) {
                            selfBlocked._coordinator?.filterByDate(dates: dateFilters,
                                                                   currentFilter: date,
                                                                   delegate: selfBlocked)
                        } else {
                            selfBlocked.view?.showNoFiltersAvailableError()
                        }
                    }
                }
            }
        }
    }

    func selectedRoverPhoto(index: Int)
    {
        _coordinator?.photoViewer(photo: _displayingPhotos[index])
    }

    func selectedRoverChanged(_ index: Int)
    {
        _currentSelectedIndex = index
        let currentRover = _roversAvailable[_currentSelectedIndex]
        if let roverMaxDate = _roversManifests.first(where: {$0.name == currentRover})?.maxDate {
            _currentDate = roverMaxDate
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
            if let selfBlocked = self {
                selfBlocked._mainQueue.sync {
                    switch result {
                    case .success(let photos):
                        if rover == selfBlocked._roversAvailable[selfBlocked._currentSelectedIndex] {
                            selfBlocked._displayingPhotos.removeAll()
                            selfBlocked._displayingPhotos.append(contentsOf: photos)
                            selfBlocked.view?.show(photos: selfBlocked._displayingPhotos)
                            selfBlocked.view?.reloadData()
                        }
                    case .failure(let err):
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
    }
}

extension BBRoverPhotosPresenter: BBFilterByDateProtocol
{
    func selected(filter: String?)
    {
        if let date = filter {
            _currentDate = date
            self._displayingPhotos.removeAll()
            self.view?.show(photos: self._displayingPhotos)
            self.view?.reloadData()
            getPhotos(for: _roversAvailable[_currentSelectedIndex], date: date)
        } else {
            selectedRoverChanged(_currentSelectedIndex)
        }
    }
}
