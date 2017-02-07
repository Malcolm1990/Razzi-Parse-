//
//  NewsFeedTableViewCell.swift
//  Razzi
//
//  Created by Marvin Campbell on 1/19/16.
//  Copyright (c) 2016 Malcolm Campbell. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var newsFeedView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var submitterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
