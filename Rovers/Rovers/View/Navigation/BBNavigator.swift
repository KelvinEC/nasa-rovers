//
//  BBNavigator.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

class BBNavigator
{
    static func navigateToPhotoViewer(photo: BBPhotoModel, from: UIViewController)
    {
        let vc = BBWireframe.createPhotoViewer(photo: photo)

        from.present(vc, animated: true, completion: nil)
    }

    static func navigateToRoversPhotosViewController(manifests: [BBRoverManifestModel], from: UIViewController)
    {
        let vc = BBWireframe.createRoverPhotoList(manifets: manifests)
        let navigation = BBWireframe.createNavigationController(vc)

        from.present(navigation, animated: true, completion: nil)
    }
}
