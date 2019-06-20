//
//  BBCameraMetadata.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

enum BBCamera: String, Codable
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
}

class BBCameraMetadata: Codable
{
    let id: Int
    let name: BBCamera
    let roverId: Int
    let fullName: String
}
