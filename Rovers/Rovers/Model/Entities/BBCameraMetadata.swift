//
//  BBCameraMetadata.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

enum BBCameraShortNameModel: String, Codable
{
    case FHAZ
    case RHAZ
    case MAST
    case CHEMCAM
    case MAHLI
    case MARDI
    case NAVCAM
    case PANCAM
    case MINITES
    case ENTRY
}

struct BBCameraModel: Codable
{
    let id: Int
    let name: BBCameraShortNameModel
    let roverId: Int
    let fullName: String
}
