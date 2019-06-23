//
//  BBFilterByDateViewProtocol.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

protocol BBFilterByDateViewProtocol: AnyObject
{
    func show(dates: [String], selected: String?)

    func reloadData()

    func dismiss()
}
