//
//  BBCreateDateFilterInteractor.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBCreateDateFilterInteractor: BBCreateDateFiltersProtocol
{
    private let _queue: DispatchQueue

    init(queue: DispatchQueue)
    {
        _queue = queue
    }

    func get(roverManifest: BBRoverManifestModel, handler: @escaping ([BBDateFilter]) -> Void)
    {
        _queue.async {
            let dates = roverManifest.photos.reduce([], {
                $0.contains($1) ? $0 : $0 + [$1] })
            handler(dates.compactMap { BBDateFilter(serverDate: $0.earthDate) })
        }
    }
}
