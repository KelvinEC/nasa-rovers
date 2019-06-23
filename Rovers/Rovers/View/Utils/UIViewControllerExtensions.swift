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
    class var storyboardID: String {
        return "\(self)_ID"
    }

    static func instantiateFromAppStoryboard(_ appStoryboard: BBAppStoryboard) -> Self
    {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

extension UIViewController: BBBaseViewProtocol
{
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

    func showError(title: String, description: String)
    {
        let controller = UIAlertController(title: title,
                                           message: description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil)

        controller.addAction(okAction)

        present(controller, animated: true, completion: nil)
    }

    func showNoInternetConnectionError()
    {
        showError(title: NSLocalizedString("Error", comment: ""),
                  description: NSLocalizedString("Your internet connection appears to be offline. :/", comment: ""))
    }

    func showUnknownError()
    {
        showError(title: NSLocalizedString("Error", comment: ""),
                  description: NSLocalizedString("The martians attacked us and" +
                    " result in an unexpected behaviour. :/ \nTry again!", comment: ""))
    }
}
