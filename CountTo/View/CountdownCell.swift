//
//  CountdownCell.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class CountdownCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeUntilEvent: UILabel!
    
    @IBOutlet weak var contentContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(event: CountdownEvent) {
        title.text = event.eventName
        timeUntilEvent.text = event.timeUntilEvent
    }
    
    func initView() {
        contentContainer.backgroundColor = UIColor.blue
        contentContainer.layer.cornerRadius = 5
        contentContainer.layer.masksToBounds = true
        
        
        
        let gradient = CAGradientLayer()

        gradient.frame = contentContainer.bounds
        gradient.colors = [UIColor(red: 0/255, green: 176/255, blue: 155/255, alpha: 1).cgColor, UIColor(red: 150/255, green: 201/255, blue: 61/255, alpha: 1).cgColor]

        contentContainer.layer.insertSublayer(gradient, at: 0)
    }

}
