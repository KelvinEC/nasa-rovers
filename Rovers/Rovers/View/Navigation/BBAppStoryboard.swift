//
//  BBAppStoryboard.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

enum BBAppStoryboard : String {
    case Main = "Main"
    case Onboarding = "Onboarding"

    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T : UIViewController>(viewControllerClass: T.Type) -> T
    {
        return self.instance.instantiateViewController(withIdentifier: viewControllerClass.storyboardID) as! T
    }
}
