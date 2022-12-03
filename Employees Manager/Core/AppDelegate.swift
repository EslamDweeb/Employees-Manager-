//
//  AppDelegate.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator:AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appCoordinator = AppCoordinator()
        appCoordinator.start()
        return true
    }


}

