//
//  file.swift
//  Rovers
//
//  Created by Kelvin Lima on 22/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

struct BBDateFilter
{
    let userDate: String
    let date: Date
    let serverDate: String

    init?(serverDate: String?)
    {
        guard let sDate = serverDate else {
            return nil
        }
        
        let userDateFormatter = DateFormatter()
        userDateFormatter.dateFormat = BBDateFormatters.user.rawValue

        let serverDateFormatter = DateFormatter()
        serverDateFormatter.dateFormat = BBDateFormatters.server.rawValue

        self.serverDate = sDate

        if let d = serverDateFormatter.date(from: self.serverDate) {
            self.date = d
        } else {
            return nil
        }

        self.userDate = userDateFormatter.string(from: self.date)
    }
}
