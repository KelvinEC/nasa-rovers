//
//  BBNetworkError.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

enum BBNetworkError: Error
{
    case noInternetConnection
    case serverUnavailable
    case connectionError
    case apiError(String)
}
