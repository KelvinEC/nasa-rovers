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
    private let _serverDateFormatter: DateFormatter

    init(roverManifestNetworking: BBManifestsNetworking)
    {
        self.roverManifestNetworking = roverManifestNetworking
        _serverDateFormatter = DateFormatter()
        _serverDateFormatter.dateFormat = BBDateFormatters.server.rawValue
    }

    func getManifest(for roverName: BBRoverNameModel,
                     handler: @escaping (Result<BBRoverManifestModel?, Error>) -> Void) {
        if let rover = BBRoverNameNetwork(rawValue: roverName.rawValue.lowercased()) {
            roverManifestNetworking.getRoverManifest(rover: rover) { result in
                switch result {
                case .success(let manifest):
                    if var photoManifest = manifest?.photoManifest {
                        photoManifest.photos.sort(by: { f, s in
                            if let fDateS = f.earthDate, let  sDateS = s.earthDate {
                                if let fDate = self._serverDateFormatter.date(from: fDateS),
                                    let sDate = self._serverDateFormatter.date(from: sDateS) {
                                    return fDate.compare(sDate) == .orderedDescending
                                }
                            }
                            return false
                        })
                        handler(.success(photoManifest))
                        return
                    }

                    handler(.success(nil))
                case .failure(let err):
                    handler(.failure(err))
                }
            }
        }
    }
}
