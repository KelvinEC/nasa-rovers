//
//  BBPresenterInjector.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBPresenterInjector
{
    static func createRoversPhotosViewControllerPresenter(coordinator: BBMainCoordinatorProtocol,
                                                          manifests: [BBRoverManifestModel]) -> BBRoverPhotosPresenter
    {
        let photosInteractor = BBInteractorsInjector.createGetRoverPhotosInteractor()
        let dateFilterInteractor = BBInteractorsInjector.createGetDateFiltersInteractor()

        return BBRoverPhotosPresenter(photosInteractor, dateFiltersInteractor: dateFilterInteractor,
                                      coordinator: coordinator, roversManifests: manifests)
    }

    static func createPhotoViewerControllerPResenter(photo: BBPhotoModel) -> BBPhotoViewerPresenter
    {
        return BBPhotoViewerPresenter(photo: photo)
    }

    static func createSyncDataControllerPresenter(coordinator: BBMainCoordinatorProtocol) -> BBSyncDataPresenter
    {
        let manifestsInteractor = BBInteractorsInjector.createGetManifestsInteractor()

        return BBSyncDataPresenter(manifestsInteractor, coordinator: coordinator)
    }

    static func createFilterByDatePresenter(_ dates: [BBDateFilter],
                                            currentFilter: BBDateFilter,
                                            delegate: BBFilterByDateProtocol) -> BBFilterByDatePresenter
    {
        return BBFilterByDatePresenter(dates, selectedValue: currentFilter, delegate: delegate)
    }
}
