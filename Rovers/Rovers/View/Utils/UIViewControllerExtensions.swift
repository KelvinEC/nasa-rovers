//
//  UIViewControllerExtensions.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

extension UIViewController
{
    class var storyboardID : String {
        return "\(self)_ID"
    }

    static func instantiateFromAppStoryboard(_ appStoryboard: BBAppStoryboard) -> Self
    {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
