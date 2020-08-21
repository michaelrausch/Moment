//
//  WidgetUpdater.swift
//  CountTo
//
//  Created by Michael Rausch on 21/08/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation

class WidgetUpdater {
    private let defaults = UserDefaults(suiteName: "group.nz.michaelrausch.CountTo")
    
    init () {
        
    }
    
    func setNextEvent(name: String, date: Date) {
        defaults!.set(name, forKey: "event_name")
        defaults!.set(date, forKey: "event_date")
        defaults!.set(true, forKey: "event_exists")
    }
}
