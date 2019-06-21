//
//  BBRoverPhotos.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

struct BBRoverPhotosModel: Codable
{
    let photos: [BBPhotoModel]
}

struct BBPhotoModel: Codable
{
    let id: Int
    let sol: Int
    let camera: BBCameraModel
    let imgSrc: String
    let earthDate: String
}
