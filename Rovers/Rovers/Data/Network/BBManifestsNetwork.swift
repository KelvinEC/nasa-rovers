//
//  BBManifestsNetwork.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBManifestsNetworking
{
    private let networkingLayer: BBNetworking
    private let mainRoute = "manifests/"

    init(_ networking: BBNetworking)
    {
        networkingLayer = networking
    }

    func getRoverManifest(rover: BBRoverNameNetwork, handler: @escaping (Result<BBManifestsModel?, Error>) -> Void)
    {
        if let request = networkingLayer.createRequest(operation: mainRoute + rover.rawValue,
                                                       type: .get,
                                                       parameters: nil) {
            networkingLayer.execute(request: request) { result in
                switch result {
                case .success(let serverResult):
                    handler(.success(serverResult.asObject()))
                case .failure(let err):
                    handler(.failure(err))
                }
            }
        }
    }
}
