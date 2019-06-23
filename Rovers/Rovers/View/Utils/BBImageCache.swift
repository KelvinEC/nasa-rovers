//
//  BBImageCache.swift
//  Rovers
//
//  Created by Kelvin Lima on 23/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit
import Kingfisher

class BBImageCache {}

protocol BBImageCacheProtocol
{
    static func setCache(maxSize: Int)

    static func prefetchImage(_ url: [URL])

    static func getImage(_ url: URL, handler: @escaping (Result<UIImage, Error>) -> Void)
}

extension BBImageCache: BBImageCacheProtocol
{
    static func setCache(maxSize: Int)
    {
        ImageCache.default.memoryStorage.config.totalCostLimit = maxSize
    }

    static func prefetchImage(_ urls: [URL])
    {
        ImagePrefetcher(urls: urls).start()
    }

    static func getImage(_ url: URL, handler: @escaping (Result<UIImage, Error>) -> Void)
    {
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let img):
                handler(.success(img.image))
            case .failure: break
            }
        }
    }
}
