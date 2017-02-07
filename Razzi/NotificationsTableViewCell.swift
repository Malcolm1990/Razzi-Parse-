//
//  NotificationsTableViewCell.swift
//  Razzi
//
//  Created by Marvin Campbell on 10/14/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationsImageView: UIImageView! = UIImageView()
    
    @IBOutlet weak var yesButton: UIButton! = UIButton()
    @IBOutlet weak var noButton: UIButton! = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
