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
    static func createNavigationController(_ root: UIViewController?) -> UINavigationController
    {
        if let r = root {
            return UINavigationController(rootViewController: r)
        }

        return UINavigationController()
    }
    
    static func createRoverPhotoList(coordinator: BBMainCoordinatorProtocol,
                                     manifests: [BBRoverManifestModel]) -> BBRoverPhotosViewController
    {
        let vc = BBRoverPhotosViewController.instantiateFromAppStoryboard(.Main)
        let eventHandler = BBPresenterInjector.createRoversPhotosViewControllerPresenter(coordinator: coordinator, manifests: manifests)

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

    static func createSyncDataScreen(coordinator: BBMainCoordinatorProtocol) -> BBSyncDataOnboardingViewController
    {
        let vc  = BBSyncDataOnboardingViewController.instantiateFromAppStoryboard(.Onboarding)
        let eventHandler = BBPresenterInjector.createSyncDataControllerPresenter(coordinator: coordinator)

        vc.eventHandler = eventHandler
        eventHandler.view = vc

        return vc
    }

    static func createOnboardingPageViewController(coordinator: BBMainCoordinatorProtocol) -> BBOnboardingPagerViewController
    {
        let vc = BBOnboardingPagerViewController.instantiateFromAppStoryboard(.Onboarding)
        vc.pages = [BBWireframe.createSyncDataScreen(coordinator: coordinator)]

        return vc
    }

    static func createFilterByDateController(_ dates: [BBDateFilter], currentFilter: BBDateFilter, delegate: BBFilterByDateProtocol) -> BBFilterByDateViewController
    {
        let vc = BBFilterByDateViewController.instantiateFromAppStoryboard(.Main)
        let eventHandler = BBPresenterInjector.createFilterByDatePresenter(dates, currentFilter: currentFilter, delegate: delegate)

        vc.eventHandler = eventHandler
        eventHandler.view = vc

        return vc
    }
}
