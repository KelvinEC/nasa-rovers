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

        return BBRoverPhotosPresenter(photosInteractor, roversManifests: manifests)
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
}
