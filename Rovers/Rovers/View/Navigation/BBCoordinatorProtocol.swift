//
//  BBCoordinatorProtocol.swift
//  Rovers
//
//  Created by Kelvin Lima on 23/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

protocol BBCoordinatorProtocol: AnyObject
{
    var childCoordinators: [BBCoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
