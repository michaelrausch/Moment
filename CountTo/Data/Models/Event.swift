//
//  CountdownEvent.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object {
    @objc dynamic var id = UUID().uuidString //Primary Key - Do not change
    @objc dynamic var eventName = ""
    @objc dynamic var eventTime = Date(timeIntervalSince1970: 1)
    @objc dynamic var imageName = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
