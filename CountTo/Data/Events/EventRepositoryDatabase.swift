//
//  EventRepositoryDatabase.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import Foundation
import RealmSwift

class EventRepositoryDatabase: EventRepository {
    let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    /**
     Get all events stored in the database
     
     - Returns: An array of events
     */
    func getAll() -> [Event] {
        return Array(realm.objects(Event.self))
    }
    
    /**
    Get all events stored in the database sorted by the date
    
    - Returns: An array of events
    */
    func getAllSortedByDate() -> [Event] {
        let events = realm.objects(Event.self)
                          .sorted(byKeyPath: "eventTime", ascending: true)
        
        return Array(events)
    }
    
    /**
     Get a single event, specified by its GUID
     
     - Returns: A single event, if one is found using the specified GUID
     */
    func get(guid: String) -> Event? {
        return realm.objects(Event.self).filter("id == \(guid)").first
    }
    
    /**
     Persist an event in the database
     
     - Parameter event: The event to add
     - Returns: hmmm
     */
    func create(event: Event) -> Bool {
        try! realm.write {
            realm.add(event)
        }
        
        return true
    }
    
    /**
     Update an event in the database.
     Note: The GUID in the event must be the same as the event being updated
     
     - Parameter event: The updated event
     */
    func update(event: Event) {
        try! realm.write {
            realm.add(event, update: .modified)
        }
    }
    
    /**
     Remove an event from the database
     
     - Parameter event: The event to remove
     */
    func delete(event: Event) {
        try! realm.write {
            realm.delete(event)
        }
    }
    
    /**
     Reset the database
     */
    func reset() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func cleanOldEvents() {
        let events = getAll()
        let calendar = Calendar.current
        let now = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: Date())

        for event in events {
            let countdownDateComponents = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: event.eventTime)
            let timeDelta = calendar.dateComponents([.day, .hour, .minute, .second], from: now, to: countdownDateComponents)
            
            if let days = timeDelta.day, days <= -1 {
                delete(event: event)
            }
        }
    }
}
