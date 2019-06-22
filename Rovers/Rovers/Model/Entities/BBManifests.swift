//
//  BBManifests.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

struct BBManifestsModel: Codable
{
    let photoManifest: BBRoverManifestModel
}

struct BBRoverManifestModel: Codable
{
    let name: BBRoverNameModel
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    var photos: [BBPhotosMetadataModel]
}
