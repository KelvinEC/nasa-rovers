//
//  UIViewControllerExtensions.swift
//  Rovers
//
//  Created by Kelvin Lima on 21/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit
import SVProgressHUD

enum ProgressHideOptions
{
    case success
    case error
    case dismiss
}

extension UIViewController
{
    class var storyboardID : String {
        return "\(self)_ID"
    }

    static func instantiateFromAppStoryboard(_ appStoryboard: BBAppStoryboard) -> Self
    {
        return appStoryboard.viewController(viewControllerClass: self)
    }

    func showProgress()
    {
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setHapticsEnabled(true)
        SVProgressHUD.show()
    }

    func hideProgress(_ option: ProgressHideOptions)
    {
        switch option {
        case .success:
            SVProgressHUD.showSuccess(withStatus: nil)
        case .error:
            SVProgressHUD.showError(withStatus: nil)
        default:
            SVProgressHUD.dismiss()
        }
    }
}
