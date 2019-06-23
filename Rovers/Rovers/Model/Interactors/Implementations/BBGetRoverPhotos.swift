//
//  BBGetRoverPhotos.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBGetRoverPhotos: BBGetRoverPhotosProtocol
{
    private let _roverPhotosNetworking: BBRoversPhotosNetworking
    private let _queue: DispatchQueue

    init(roverPhotosNetworking: BBRoversPhotosNetworking, queue: DispatchQueue)
    {
        self._roverPhotosNetworking = roverPhotosNetworking
        _queue = queue
    }

    func get(for roverName: BBRoverNameModel, date: String,
             handler: @escaping (Result<[BBPhotoModel], Error>) -> Void)
    {
        if let rover = BBRoverNameNetwork(rawValue: roverName.rawValue.lowercased()) {
            self._roverPhotosNetworking.getRoverPhotos(rover: rover, date: date) { [weak self] result in
                self?._queue.async {
                    switch result {
                    case .success(let photos):
                        var response = [BBPhotoModel]()

                        if let p = photos {
                            for var photo in p.photos {
                                photo.imgSrc = photo.imgSrc.replacingOccurrences(of: "http://", with: "https://")
                                response.append(photo)
                            }

                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = BBDateFormatters.server.rawValue

                            response = response.sorted { f, s in
                                if let fDate = dateFormatter.date(from: f.earthDate), let sDate = dateFormatter.date(from: s.earthDate) {
                                    return fDate.compare(sDate) == .orderedDescending
                                }

                                return false
                            }
                        }

                        handler(.success(response))
                    case .failure(let err): handler(.failure(err))
                    }
                }
            }
        }
    }
}
