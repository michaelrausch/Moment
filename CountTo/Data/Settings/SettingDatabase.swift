//
//  SettingDatabase.swift
//  CountTo
//
//  Created by Michael Rausch on 13/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation
import RealmSwift

class SettingDatabase: SettingRepository {
    let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    /**
     Get all settings stored in the database
     
     - Returns: An array of settings
     */
    func getAll() -> [Setting] {
        return Array(realm.objects(Setting.self))
    }
    
    /**
     Get a single setting, specified by its name
     
     - Returns: A single event, if one is found using the specified GUID
     */
    func get(setting name: String) -> Setting? {
        let result = realm.objects(Setting.self).filter("settingName = %@", name)
        
        return result.first
    }
    
    /**
     Persist a setting in the database
     
     - Parameter setting: The event to add
     - Returns: hmmm
     */
    func create(setting: Setting) -> Bool {
        try! realm.write {
            realm.add(setting)
        }
        
        return true
    }
    
    /**
     Update a setting in the database.
     Note: The GUID in the event must be the same as the event being updated
     
     - Parameter setting: The updated setting
     */
    func update(setting: Setting) -> Bool {
        try! realm.write {
            realm.add(setting, update: .modified)
        }
        
        return true
    }
    
    /**
     Remove an event from the database
     
     - Parameter setting: The setting to remove
     */
    func delete(setting: Setting) -> Bool {
        try! realm.write {
            realm.delete(setting)
        }
        
        return true
    }
    
    /**
     Reset the database
     */
    func reset() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
