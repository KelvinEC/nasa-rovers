//
//  BBAppStoryboard.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

enum BBAppStoryboard: String
{
    case main = "Main"
    case onboarding = "Onboarding"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    //swiftlint:disable force_cast
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T
    {
        return self.instance.instantiateViewController(withIdentifier: viewControllerClass.storyboardID) as! T
    }
}
