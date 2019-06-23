//
//  BBRoversPhotosNetwork.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

enum BBRoversPhotosParameters: String
{
    case earthDate = "earth_date"
    case page = "page"
}

class BBRoversPhotosNetworking
{
    private let networkingLayer: BBNetworking
    private let mainRoute = "rovers/"
    private let finalRoute = "/photos"

    init(_ networking: BBNetworking)
    {
        networkingLayer = networking
    }

    func getRoverPhotos(rover: BBRoverNameNetwork, date: String, page: Int,
                          handler: @escaping (Result<BBRoverPhotosModel?, Error>) -> Void)
    {
        if let request = networkingLayer.createRequest(operation: mainRoute + rover.rawValue + finalRoute,
                                                       type: .get,
                                                       parameters: [BBRoversPhotosParameters.earthDate.rawValue: date,
                                                        BBRoversPhotosParameters.page.rawValue: page]) {
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
