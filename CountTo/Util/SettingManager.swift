//
//  SettingManager.swift
//  CountTo
//
//  Created by Michael Rausch on 13/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation

class SettingManager {
    let database: SettingRepository
    
    init() {
        database = SettingDatabase()
    }
    
    func getSetting(setting: SettingName) -> String? {
        if let result = database.get(setting: setting.rawValue) {
            return result.value;
        }
        
        return nil;
    }
    
    func setSetting(setting: SettingName, value: String) {
        if let existingSetting = database.get(setting: setting.rawValue) {
            let update = Setting()
            update.id = existingSetting.id
            update.settingName = existingSetting.settingName
            update.value = value
            database.update(setting: update)
        }
        else {
            let newSetting = Setting()
            newSetting.settingName = setting.rawValue
            newSetting.value = value
            database.create(setting: newSetting)
        }
    }
    
    func setSetting(setting: SettingName, value: SettingValue) {
        setSetting(setting: setting, value: value.rawValue)
    }
    
    func isPremiumEnabled() -> Bool {
        if let result = getSetting(setting: .premium) {
            if result == SettingValue.enabled.rawValue {
                return true
            }
        }
        return false
    }
    
    func enablePremium() {
        setSetting(setting: .premium, value: .enabled)
    }
    
    func disablePremium() {
        setSetting(setting: .premium, value: .disabled)
    }
    
}

enum SettingName: String {
    case premium = "PREMIUM"
    case initialLaunch = "INITIAL_LAUNCH"
}

enum SettingValue: String {
    case enabled = "ENABLED"
    case disabled = "DISABLED"
}
