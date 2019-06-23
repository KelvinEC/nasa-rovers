//
//  BBGetRoverPhotosProtocol.swift
//  Rovers
//
//  Created by Kelvin Lima on 23/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

protocol BBGetRoverPhotosProtocol
{
    func get(for roverName: BBRoverNameModel, date: String, page: Int,
             handler: @escaping (Result<[BBPhotoModel], Error>) -> Void)
}
