//
//  BBQueueInjector.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

class BBQueues
{
    static let interactorsQueue = DispatchQueue(label: "BBInteractorsQueue", qos: .userInitiated)

    static let dataQueue = DispatchQueue(label: "BBDataQueue", qos: .background)
}
