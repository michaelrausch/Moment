//
//  ImageStore.swift
//  CountTo
//
//  Created by Michael Rausch on 12/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation

class ImageStore {
    let plistName: String = "Images"
    var images: [String] = []
    
    init() {
        do {
            images = try loadPlist()
        } catch {
            print("Failed to load Image Plist")
        }
    }
    
    private func loadPlist() throws -> [String] {
        if let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let imageNames = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String] {
            
            return imageNames
        }
        return []
    }
    
    func getImages() -> [String] {
        return images
    }
}
