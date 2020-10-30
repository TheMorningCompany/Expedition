//
//  AppDelegate.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 8/16/19.
//  Copyright © 2019 The Morning Company. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var scheme: String!
    var path: String!

    var query: String!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let roleArray = ViewController().credits.components(separatedBy: ";")
        for person in roleArray {
            let personArray = person.components(separatedBy: ":")
            let personName = personArray[0]
            let personRole = personArray[1]
            print(personName + ": " + personRole)
            UserDefaults.standard.set(personRole, forKey: personName)
            
            
            let launchedBefore = UserDefaults.standard.bool(forKey: "has_opened")
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let launchStorybard = UIStoryboard(name: "Onboarding", bundle: nil)
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            var vc: UIViewController
            if launchedBefore {
                vc = mainStoryboard.instantiateInitialViewController()!
                
            } else {
                vc = launchStorybard.instantiateViewController(identifier: "customizeStoryboard")
            }
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            
            
            
        }
//        UserDefaults.standard.set(ViewController().credits, forKey: "creditsTitle")
        UINavigationBar.appearance().shadowImage = UIImage()
        return true
        
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
//        if shortcutItems.isEmpty {
            shortcutItems = [
                UIApplicationShortcutItem(type: "Search Something", localizedTitle: "Search Something")
                //UIApplicationShortcutItem(type: "Test Type 1", localizedTitle: "Test Title 1")
            ]
            if let mutableShortcutItem = shortcutItems.first?.mutableCopy() as? UIMutableApplicationShortcutItem {
                mutableShortcutItem.icon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.search)
                shortcutItems[0] = mutableShortcutItem
            }
//        } else {
//            if let mutableShortcutItem = shortcutItems.first?.mutableCopy() as? UIMutableApplicationShortcutItem {
//                mutableShortcutItem.type = "Updated Type 0"
//                mutableShortcutItem.localizedTitle = "Updated Title 0"
//                mutableShortcutItem.icon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.love)
//                shortcutItems[0] = mutableShortcutItem
//            }
//        }
        UIApplication.shared.shortcutItems = shortcutItems
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        if (UserDefaults.standard.bool(forKey: "keep_cookies")) {
            HistoryTableViewController().removeCookies()
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        if (UserDefaults.standard.bool(forKey: "keep_cookies")) {
            HistoryTableViewController().removeCookies()
        }
        PersistenceService.saveContext()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        print("URL OPENED")
        
        ViewController().schemeHandling(url: url)
        
        return true
    }

}

