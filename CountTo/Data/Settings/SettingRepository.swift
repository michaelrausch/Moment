//
//  SettingRepository.swift
//  CountTo
//
//  Created by Michael Rausch on 13/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation

protocol SettingRepository {
    func getAll() -> [Setting]
    func get(setting name: String) -> Setting?
    func create(setting: Setting) -> Bool
    func update(setting: Setting) -> Bool
    func delete(setting: Setting) -> Bool
    func reset()
}
