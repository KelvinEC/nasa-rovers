//
//  BBCreateDateFiltersProtocol.swift
//  Rovers
//
//  Created by Kelvin Lima on 23/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

protocol BBCreateDateFiltersProtocol
{
    func get(roverManifest: BBRoverManifestModel, handler: @escaping ([BBDateFilter]) -> Void)
}
