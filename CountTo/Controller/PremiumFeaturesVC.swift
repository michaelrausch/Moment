//
//  PremiumFeaturesVC.swift
//  CountTo
//
//  Created by Michael Rausch on 21/08/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation
import UIKit

class PremiumFeaturesVC: UIViewController {
    @IBOutlet weak var removeEventsToggle: UISwitch!
    @IBOutlet weak var remindersToggle: UISwitch!
    
    let settingManager = SettingManager()
    let notificationManager = NotificationManager()
    
    override func viewDidLoad() {
        if settingManager.isCleanupEnabled() {
            removeEventsToggle.setOn(true, animated: true)
        }
        else {
            removeEventsToggle.setOn(false, animated: true)
        }
        
        if settingManager.isRemindersEnabled() {
            remindersToggle.setOn(true, animated: true)
        }
        else {
            remindersToggle.setOn(false, animated: true)
        }
    }
    
    @IBAction func removeEventsToggled(_ sender: Any) {
        if removeEventsToggle.isOn {
            settingManager.enableCleanup()
        }
        else {
            settingManager.disableCleanup()
        }
    }
    
    @IBAction func remindersToggled(_ sender: Any) {
        if remindersToggle.isOn {
            settingManager.enableReminders()
            notificationManager.enableAllReminders()
        }
        else {
            settingManager.disableReminders()
            notificationManager.removeAllReminders()
        }
    }
}
