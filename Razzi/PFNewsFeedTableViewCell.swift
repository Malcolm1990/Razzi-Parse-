//
//  PFNewsFeedTableViewCell.swift
//  Razzi
//
//  Created by Marvin Campbell on 1/21/16.
//  Copyright (c) 2016 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PFNewsFeedTableViewCell: PFTableViewCell {

    //Connects UI to code
    @IBOutlet weak var pFNewsFeedView: PFImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var submitterLabel: UILabel! 
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
