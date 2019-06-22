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
    
    static func createRoverPhotoList(manifets: [BBRoverManifestModel]) -> BBRoverPhotosViewController
    {
        let vc = BBRoverPhotosViewController.instantiateFromAppStoryboard(.Main)
        let eventHandler = BBPresenterInjector.createRoversPhotosViewControllerPresenter(manifests: manifets)

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

    static func createWelcomeScreen() -> BBWelcomeOnboardingViewController
    {
        return BBWelcomeOnboardingViewController.instantiateFromAppStoryboard(.Onboarding)
    }

    static func createSyncDataScreen() -> BBSyncDataOnboardingViewController
    {
        let vc  = BBSyncDataOnboardingViewController.instantiateFromAppStoryboard(.Onboarding)
        let eventHandler = BBPresenterInjector.createSyncDataControllerPresenter()

        vc.eventHandler = eventHandler
        eventHandler.view = vc

        return vc
    }

    static func createOnboardingPageViewController() -> BBOnboardingPagerViewController
    {
        let vc = BBOnboardingPagerViewController.instantiateFromAppStoryboard(.Onboarding)
        vc.pages = [BBWireframe.createSyncDataScreen()]

        return vc
    }
}
