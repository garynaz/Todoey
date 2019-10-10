//
//  AppDelegate.swift
//  Todoey
//
//  Created by Gary Naz on 9/5/19.
//  Copyright © 2019 Gari Nazarian. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do {
             _ = try Realm()
        } catch {
            print("Error initializing new realm, \(error)")
        }
        
        return true
    }
   
}

