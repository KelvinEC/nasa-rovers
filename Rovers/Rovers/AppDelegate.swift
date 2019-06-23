//
//  AppDelegate.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var coordinator: BBMainCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let mainNav = BBWireframe.createNavigationController(nil)

        coordinator = BBMainCoordinator(navigationController: mainNav)
        coordinator?.start()

        let frame = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)

        self.window?.rootViewController = mainNav
        self.window?.makeKeyAndVisible()

        BBNetworking.shared.set(authorization: "Ec39O4C3p9Yqi2DuRHQYBBMfNNsW65lzM3V0Qtvo")

        BBImageCache.setCache(maxSize: 300 * 1024 * 1024) //300Mb of image Cache
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
    }
}
