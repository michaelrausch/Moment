//
//  BackgroundImagePickerCV.swift
//  CountTo
//
//  Created by Michael Rausch on 12/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import UIKit

class BackgroundImagePickerCV: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    var images: [String] = []
    var selectedImage: String = ""
    var imagePickerDelegate: BackgroundImagePickerDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        loadImageList()
        
        if images.count > 0 {
            selectedImage = images[0]
        }
        
        if imagePickerDelegate != nil {
            imagePickerDelegate?.imageSelected(with: selectedImage)
        }
                
        self.dataSource = self
        self.delegate = self
    }
    
    func loadImageList() {
        let sm = SettingManager()
        let store = ImageStore()
        
        images = store.getFreeImages()

        if sm.isPremiumEnabled() {
            images = store.getPremiumImages()
        }
    }
    
    func setInitialImage(image: String) {
        var foundPosition = 0
        
        for i in 0 ..< images.count {
            if images[i] == image {
                foundPosition = i
            }
        }
        
        if foundPosition != 0 {
            let temp = images[0]
            images[0] = images[foundPosition]
            images[foundPosition] = temp
        }
    }
}

extension BackgroundImagePickerCV {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BackgroundImageCell", for: indexPath) as! BackgroundImageCell
        
        cell.setImage(to: images[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageName = images[indexPath.item]
        
        if imagePickerDelegate != nil {
            imagePickerDelegate?.imageSelected(with: imageName)
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! BackgroundImageCell
        cell.setSelected()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BackgroundImageCell {
            cell.setDeselected()
        }
    }
}

protocol BackgroundImagePickerDelegate {
    func imageSelected(with name: String);
}
