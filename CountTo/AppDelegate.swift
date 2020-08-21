//
//  AppDelegate.swift
//  CountTo
//
//  Created by Michael Rausch on 12/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if CommandLine.arguments.contains("--uitesting") {
            resetState()
        }
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 29)!
        ]

        UINavigationBar.appearance().largeTitleTextAttributes = attrs

        runCleanup()
        updateWidget()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    /**
     Reset the applications state before testing
     */
    func resetState() {
        let repo = EventRepositoryDatabase()
        repo.reset()

        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
    
    func runCleanup() {
        let sm = SettingManager()
        let events = EventRepositoryDatabase()

        if sm.isCleanupEnabled() {
            events.cleanOldEvents()
        }
    }
    
    func updateWidget() {
        let events = EventRepositoryDatabase().getAllSortedByDate()
        
        if events.count > 0 {
            WidgetUpdater().setNextEvent(name: events[0].eventName, date: events[0].eventTime)
        }
        
    }

}

