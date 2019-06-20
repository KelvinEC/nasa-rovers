//
//  BBPhotos.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBPhotosMetadata: Codable
{
    let sol: Int
    let earthDate: String
    let totalPhotos: Int
    let cameras: [BBCamera]
}
