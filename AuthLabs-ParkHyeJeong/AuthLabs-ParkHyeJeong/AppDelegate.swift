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
        setRootDestination()
        return true
    }
}

private extension AppDelegate {
    func setRootDestination() {
        let rootViewController = ViewController()
        rootViewController.view.backgroundColor = .cyan
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}
