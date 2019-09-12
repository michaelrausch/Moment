//
//  CountdownEvent.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import Foundation

class CountdownEvent {
    private var _eventName: String!
    private var _timeUntilEvent: String!
    
    var eventName: String {
        return _eventName
    }
    
    var timeUntilEvent: String {
        return _timeUntilEvent
    }
    
    init(title: String, timeUntilEvent: String) {
        _eventName = title
        _timeUntilEvent = timeUntilEvent
    }
}
