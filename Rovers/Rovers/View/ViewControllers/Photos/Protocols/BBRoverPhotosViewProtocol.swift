//
//  BBRoverPhotosViewProtocol.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

protocol BBRoverPhotosViewProtocol: AnyObject, BBBaseViewProtocol
{
    func showNoFiltersAvailableError()

    func reloadData()

    func show(photos: [BBPhotoModel])

    func show(rovers: [String])

    func appendPhotos(photos: [BBPhotoModel])

    func insert(numberOf rows: Int)
}
