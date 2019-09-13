//
//  DeleteButton.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class DeleteButton: LargeButton {

    override func setupButton() {
        super.setupButton()
        
        layer.backgroundColor = UIColor.systemRed.cgColor
    }

}
