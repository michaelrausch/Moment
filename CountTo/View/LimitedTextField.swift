//
//  LimitedTextField.swift
//  CountTo
//
//  Created by Michael Rausch on 12/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import UIKit

/**
 A text field with a specified limit
 */
class LimitedTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTarget(self, action: #selector(LimitedTextField.textChanged(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textChanged(_ textField: UITextField) {
        let text = textField.text
        
        if let text = text {
            var charCount = text.count
            
            if charCount > Const.FORM_FIELD_MAX_CHAR_COUNT {
                let shortened = String(text.prefix(Const.FORM_FIELD_MAX_CHAR_COUNT))
                textField.text = shortened
                charCount = shortened.count
            }            
        }
    }
}
