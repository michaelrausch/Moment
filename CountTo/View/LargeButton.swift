//
//  LargeButton.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class LargeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        layer.cornerRadius = 10
        layer.backgroundColor = UIColor.label.resolvedColor(with: self.traitCollection).cgColor
        setTitleColor(.systemGray6, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 22)
    }
}
