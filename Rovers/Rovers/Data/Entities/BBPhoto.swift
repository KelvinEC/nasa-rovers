//
//  BBPhotos.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBPhoto: Codable
{
    let id: Int
    let sol: Int
    let camera: BBCameraMetadata
    let imgSrc: String
    let earthDate: String
}
