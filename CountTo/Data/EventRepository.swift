//
//  EventRepository.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import Foundation

protocol EventRepository {
    func getAll() -> [Event]
    func get(guid: String) -> Event?
    func create(event: Event) -> Bool
    func update(event: Event) -> Bool
    func delete(event: Event) -> Bool
    func reset()
}
