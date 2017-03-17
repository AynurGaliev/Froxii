//
//  AppDelegate.swift
//  Froxii
//
//  Created by Aynur Galiev on 13.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        return window
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        self.setupAppearance()
        return true
    }
    
    func setupAppearance() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    }
}

