//
//  ImageStore.swift
//  CountTo
//
//  Created by Michael Rausch on 12/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation

class ImageStore {
    let FREE_IMAGES = ["redgradient", "bluegradient", "greengradient", "purplegradient"]
    let PREMIUM_IMAGES = ["apricot", "fireworks", "pattern1", "wall"]
    
    init() {

    }
    
    func getFreeImages() -> [String] {
        return FREE_IMAGES
    }
    
    func getPremiumImages() -> [String] {
        var allImages = FREE_IMAGES
        allImages.append(contentsOf: PREMIUM_IMAGES)
        
        return allImages
    }
}
