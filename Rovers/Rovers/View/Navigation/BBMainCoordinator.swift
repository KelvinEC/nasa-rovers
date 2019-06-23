//
//  BBMainCoordinator.swift
//  Rovers
//
//  Created by Kelvin Lima on 23/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

class BBMainCoordinator
{
    var childCoordinators = [BBCoordinatorProtocol]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }

    func start()
    {
        let vc = BBWireframe.createOnboardingPageViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
}

extension BBMainCoordinator: BBMainCoordinatorProtocol
{
    func roversPhotos(to manifests: [BBRoverManifestModel])
    {
        let vc = BBWireframe.createRoverPhotoList(coordinator: self, manifests: manifests)

        navigationController.setViewControllers([vc], animated: true)
    }

    func photoViewer(photo: BBPhotoModel)
    {
        let vc = BBWireframe.createPhotoViewer(photo: photo)

        self.navigationController.present(vc, animated: true, completion: nil)
    }

    func filterByDate(dates: [BBDateFilter], currentFilter: BBDateFilter, delegate: BBFilterByDateProtocol)
    {
        let vc = BBWireframe.createFilterByDateController(dates, currentFilter: currentFilter, delegate: delegate)
        let navigation = BBWireframe.createNavigationController(vc)

        self.navigationController.present(navigation, animated: true, completion: nil)
    }
}
