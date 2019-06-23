//
//  BBBaseViewProtocol.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

protocol BBBaseViewProtocol
{
    func showProgress()
    
    func hideProgress(_ option: ProgressHideOptions)
    
    func showError(title: String, description: String)
    
    func showNoInternetConnectionError()
    
    func showUnknownError()
}
