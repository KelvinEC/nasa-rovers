//
//  BBGetRoverManifestProtocol.swift
//  Rovers
//
//  Created by Kelvin Lima on 23/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

protocol BBGetRoverManifestProtocol
{
    func getManifest(for roverName: BBRoverNameModel,
                     handler: @escaping (Result<BBRoverManifestModel?, Error>) -> Void)
}
