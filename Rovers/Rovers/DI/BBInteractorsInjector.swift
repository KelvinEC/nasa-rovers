//
//  BBInteractorsInjector.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBInteractorsInjector
{
    static func createGetManifestsInteractor() -> BBGetRoverManifest
    {
        let manifestNetworking = BBDataInjector.createManifestsNetwork()
        return BBGetRoverManifest(roverManifestNetworking: manifestNetworking, queue: BBQueues.interactorsQueue)
    }

    static func createGetRoverPhotosInteractor() -> BBGetRoverPhotos
    {
        let photosNetworking = BBDataInjector.createRoverPhotosNetwork()
        return BBGetRoverPhotos(roverPhotosNetworking: photosNetworking, queue: BBQueues.interactorsQueue)
    }

    static func createGetDateFiltersInteractor() -> BBCreateDateFilterInteractor
    {
        return BBCreateDateFilterInteractor(queue: BBQueues.interactorsQueue)
    }
}
