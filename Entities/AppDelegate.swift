//
//  AppDelegate.swift
//  Entities
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit
import ListScreen

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let entityListNC = ListScreenBuilder.buildNC()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = entityListNC
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

