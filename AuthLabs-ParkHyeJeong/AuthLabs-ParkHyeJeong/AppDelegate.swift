//
//  AppDelegate.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/21/24.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setWindow()
        setRootDestination()
        return true
    }
}

private extension AppDelegate {
    func setWindow() {
        self.window = UIWindow()
    }
    
    func setRootDestination() {
        let rootViewController = ViewController()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}
