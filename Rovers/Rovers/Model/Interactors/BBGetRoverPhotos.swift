//
//  BBGetRoverPhotos.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBGetRoverPhotos
{
    private let roverPhotosNetworking: BBRoversPhotosNetworking

    init(roverPhotosNetworking: BBRoversPhotosNetworking)
    {
        self.roverPhotosNetworking = roverPhotosNetworking
    }

    func get(for roverName: BBRoverNameModel, date: String,
             handler: @escaping (Result<[BBPhotoModel]?, Error>) -> Void)
    {
        if let rover = BBRoverNameNetwork(rawValue: roverName.rawValue.lowercased()) {
            self.roverPhotosNetworking.getRoverPhotos(rover: rover, date: date) { result in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-DD"
                switch result {
                case .success(let photos):
                    let photosSorted = photos?.photos.sorted { f, s in
                        if let fDate = dateFormatter.date(from: f.earthDate), let sDate = dateFormatter.date(from: s.earthDate) {
                            return fDate.compare(sDate) == .orderedDescending
                        }

                        return false
                    }

                    handler(.success(photosSorted))
                case .failure(let err): handler(.failure(err))
                }
            }
        }
    }
}
