//
//  AppDelegate.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 25.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TutorialViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
