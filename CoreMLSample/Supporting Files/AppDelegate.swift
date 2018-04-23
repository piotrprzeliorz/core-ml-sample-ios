//
//  AppDelegate.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 13.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootConnector: RootConnector?

    // MARK:- Application's life cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupNavigation()
        return true
    }

    //MARK:- Main

    private func setupNavigation() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let `window` = window else { fatalError("Window couldn't be initialized") }
        window.makeKeyAndVisible()
        rootConnector = RootConnector(with: window)
    }
}

