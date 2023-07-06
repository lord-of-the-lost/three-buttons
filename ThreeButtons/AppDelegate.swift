//
//  AppDelegate.swift
//  ThreeButtons
//
//  Created by Николай Игнатов on 04.07.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FirstViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

