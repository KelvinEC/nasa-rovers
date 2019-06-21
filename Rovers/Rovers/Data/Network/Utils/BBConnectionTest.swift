//
//  BBConnectionTest.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit

/// Describes response of connection check test.
internal enum LKConnectionTestResponse: Int
{
    case success
    case failure
}

/// Class that checks if really has internet connection attempting to connect to Captive apple server.
internal class LKConnectionTest: NSObject
{
    /// Tests the internet connection using Apple's captive portal.
    ///
    /// - Warning: This method should never be used to prevent network operations.
    /// - Parameter handler: Handler that receives the result of the connection test.
    static func checkInternetConnection(handler: @escaping (LKConnectionTestResponse) -> Void)
    {
        let url = URL(string: "http://captive.apple.com")

        let task = URLSession.shared.dataTask(with: url!) {(data, _, error) in
            guard error != nil && data != nil else {
                handler(.failure)
                return
            }

            if let contentResponse = String(data: data!, encoding: .utf8) {
                if contentResponse == "<HTML><HEAD><TITLE>Success</TITLE></HEAD><BODY>Success</BODY></HTML>" {
                    //TODO: Stops passing raw value when objc is no longe necessary
                    handler(.success)
                }
            }
            //TODO: Stops passing raw value when objc is no longe necessary
            handler(.failure)
        }

        task.resume()
    }
}
