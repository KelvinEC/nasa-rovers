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
    static func createRoversPhotosViewControllerPresenter(manifests: [BBRoverManifestModel]) -> BBRoverPhotosPresenter
    {
        let photosInteractor = BBInteractorsInjector.createGetRoverPhotosInteractor()
        let dateFilterInteractor = BBInteractorsInjector.createGetDateFiltersInteractor()

        return BBRoverPhotosPresenter(photosInteractor, dateFiltersInteractor: dateFilterInteractor, roversManifests: manifests)
    }

    static func createPhotoViewerControllerPResenter(photo: BBPhotoModel) -> BBPhotoViewerPresenter
    {
        return BBPhotoViewerPresenter(photo: photo)
    }

    static func createSyncDataControllerPresenter() -> BBSyncDataPresenter
    {
        let manifestsInteractor = BBInteractorsInjector.createGetManifestsInteractor()

        return BBSyncDataPresenter(manifestsInteractor)
    }

    static func createFilterByDatePresenter(_ dates: [BBDateFilter], delegate: BBFilterByDateProtocol) -> BBFilterByDatePresenter
    {
        return BBFilterByDatePresenter(dates, delegate: delegate)
    }
}
