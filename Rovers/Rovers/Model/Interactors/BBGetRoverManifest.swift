//
//  BBGetRoverManifest.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBGetRoverManifest
{
    private let roverManifestNetworking: BBManifestsNetworking

    init(roverManifestNetworking: BBManifestsNetworking)
    {
        self.roverManifestNetworking = roverManifestNetworking
    }

    func getManifest(for roverName: BBRoverNameModel,
                     handler: @escaping (Result<BBRoverManifestModel?, Error>) -> Void) {
        if let rover = BBRoverNameNetwork(rawValue: roverName.rawValue.lowercased()) {
            roverManifestNetworking.getRoverManifest(rover: rover) { result in
                switch result {
                case .success(let manifest):
                    handler(.success(manifest?.photoManifest))
                case .failure(let err):
                    handler(.failure(err))
                }
            }
        }
    }
}
