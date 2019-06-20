//
//  BBPhotoManifest.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBPhotoManifest: Codable
{
    let name: BBRoverName
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let photos: [BBPhotosMetadata]
}
