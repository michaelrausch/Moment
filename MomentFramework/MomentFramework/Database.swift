//
//  Database.swift
//  MomentFramework
//
//  Created by Michael Rausch on 21/08/20.
//

import Foundation

class Database {
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return self.name
    }
}
