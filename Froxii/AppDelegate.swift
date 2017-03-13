//
//  AppDelegate.swift
//  Froxii
//
//  Created by Aynur Galiev on 13.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        return window
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        self.setupAppearance()
        
        return true
    }
    
    func setupAppearance() {
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.backgroundColor = UIColor.white
        navigationBar.backIndicatorImage = UIImage()

    }
}

