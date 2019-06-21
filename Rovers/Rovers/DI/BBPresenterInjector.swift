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
    static func createRoversPhotosViewControllerPresenter() -> BBRoverPhotosPresenter
    {
        let manifestsInteractor = BBInteractorsInjector.createGetManifestsInteractor()
        let photosInteractor = BBInteractorsInjector.createGetRoverPhotosInteractor()

        return BBRoverPhotosPresenter(roverManifestInteractor: manifestsInteractor,
                                      roverPhotosInteractor: photosInteractor)
    }

    static func createPhotoViewerControllerPResenter(photo: BBPhotoModel) -> BBPhotoViewerPresenter
    {
        return BBPhotoViewerPresenter(photo: photo)
    }
}
