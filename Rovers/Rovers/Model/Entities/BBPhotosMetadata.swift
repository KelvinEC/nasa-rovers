//
//  BBPhotos.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

struct BBPhotosMetadataModel: Codable
{
    let sol: Int
    let earthDate: String?
    let totalPhotos: Int
    let cameras: [BBCameraShortNameModel]
}

extension BBPhotosMetadataModel: Equatable
{
    static func == (lhs: BBPhotosMetadataModel, rhs: BBPhotosMetadataModel) -> Bool {
        return lhs.earthDate == rhs.earthDate
    }
}
