//
//  BBMainCoordinatorProtocol.swift
//  Rovers
//
//  Created by Kelvin Lima on 23/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

protocol BBMainCoordinatorProtocol: BBCoordinatorProtocol
{
    func roversPhotos(to manifests: [BBRoverManifestModel])

    func photoViewer(photo: BBPhotoModel)

    func filterByDate(dates: [BBDateFilter], currentFilter: BBDateFilter, delegate: BBFilterByDateProtocol)
}
