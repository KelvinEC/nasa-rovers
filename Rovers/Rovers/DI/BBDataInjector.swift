//
//  BBDataInjector.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBDataInjector
{
    static func createManifestsNetwork() -> BBManifestsNetworking
    {
        return BBManifestsNetworking(BBNetworking.shared)
    }

    static func createRoverPhotosNetwork() -> BBRoversPhotosNetworking
    {
        return BBRoversPhotosNetworking(BBNetworking.shared)
    }
}
