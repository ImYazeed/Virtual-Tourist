//
//  AppDelegate.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 20/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       DataController.shared.load()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        DataController.shared.saveContext()
    }
}

