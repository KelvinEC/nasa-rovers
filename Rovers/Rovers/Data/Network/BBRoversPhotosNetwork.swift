//
//  BBRoversPhotosNetwork.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBRoversPhotosNetworking
{
    private let networkingLayer: BBNetworking
    private let mainRoute = "rovers/"
    private let finalRoute = "/photos"

    init(_ networking: BBNetworking)
    {
        networkingLayer = networking
    }

    func getRoverManifest(rover: BBRoverNameNetwork, date: String,
                          handler: @escaping (Result<BBRoverPhotos?, Error>) -> Void)
    {
        if let request = networkingLayer.createRequest(operation: mainRoute + rover.rawValue + finalRoute, type: .get, parameters: ["earth_date": date]) {
            networkingLayer.execute(request: request) { result in
                switch result {
                case .success(let photos):
                    handler(.success(photos.asObject()))
                case .failure(let err):
                    handler(.failure(err))
                }
            }
        }
    }
}
