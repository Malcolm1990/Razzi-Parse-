//
//  PFNotificationsTableViewCell.swift
//  Razzi
//
//  Created by Marvin Campbell on 12/8/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PFNotificationsTableViewCell: PFTableViewCell {

    //Connect UI to code
    @IBOutlet weak var pFNotificationsImageView: PFImageView!
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
}
