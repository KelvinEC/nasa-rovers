//
//  BBWireframe.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

class BBWireframe
{
    static func createNavigationController(_ root: UIViewController) -> UINavigationController
    {
        return UINavigationController(rootViewController: root)
    }
    
    static func createRoverPhotoList() -> BBRoverPhotosViewController
    {
        let vc = BBRoverPhotosViewController.instantiateFromAppStoryboard(.Main)
        let eventHandler = BBPresenterInjector.createRoversPhotosViewControllerPresenter()

        eventHandler.view = vc
        vc.eventHandler = eventHandler

        return vc
    }

    static func createPhotoViewer(photo: BBPhotoModel) -> BBPhotoViewerViewController
    {
        let vc = BBPhotoViewerViewController.instantiateFromAppStoryboard(.Main)
        let eventHandler = BBPresenterInjector.createPhotoViewerControllerPResenter(photo: photo)

        vc.eventHandler = eventHandler
        eventHandler.view = vc

        return vc
    }
}
