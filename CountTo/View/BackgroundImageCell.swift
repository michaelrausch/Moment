//
//  BackgroundImageCell.swift
//  CountTo
//
//  Created by Michael Rausch on 12/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import UIKit

class BackgroundImageCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var contentContainer: UIImageView!
    
    private var imageName: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentContainer.layer.cornerRadius = 5
        contentContainer.layer.masksToBounds = true
        
        if self.traitCollection.userInterfaceStyle == .dark {
            contentContainer.layer.borderColor = UIColor.white.cgColor
        }
        else {
            contentContainer.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func setImage(to imageName: String) {
        self.imageName = imageName
        image.image = UIImage(named: imageName)
    }
    
    func setSelected() {
        contentContainer.layer.borderWidth = 3.0
    }

    func setDeselected() {
        contentContainer.layer.borderWidth = 0
    }
    
    func getImageName() -> String {
        return imageName
    }
    
}
