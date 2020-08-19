//
//  Setting.swift
//  CountTo
//
//  Created by Michael Rausch on 13/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation
import RealmSwift

class Setting: Object {
    @objc dynamic var id = UUID().uuidString //Primary Key - Do not change
    @objc dynamic var settingName = ""
    @objc dynamic var value = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
