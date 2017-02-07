//
//  PFProfileTableViewController.swift
//  Razzi
//
//  Created by Marvin Campbell on 12/10/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class PFProfileTableViewController: PFQueryTableViewController {
    
    //Declare variable
    var user = PFUser.currentUser()
    
    /*override func viewDidLoad() {
        let alertMessage = UIAlertView(title: "Profile Tab", message: "This tab shows the photos that you post from your notifications", delegate: self, cancelButtonTitle: "OK")
        alertMessage.show()
        
    }*/
    
    
    override func queryForTable() -> PFQuery {
        
        //Declare constant and connect it to query class
        let findProfileData = PFQuery(className: "Content")
        
        //Refine query
        findProfileData.whereKey("user", equalTo: PFUser.currentUser()!)
        
        //Order found object in descending order
        findProfileData.orderByDescending("createdAt")
        
        return findProfileData
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        //Declare constant and connect it to the storyboard cell
        let cell = tableView.dequeueReusableCellWithIdentifier("PFProfileCell", forIndexPath: indexPath) as! PFProfileTableViewCell
        
        //Declare constant and connect it to the queried object
        let imageConstant = object?.objectForKey("content") as? PFFile
        
        //Connect constant to storyboard imageView
        cell.pFProfileImageView.image = UIImage(named: "placeholder")
        cell.pFProfileImageView.file = imageConstant
        cell.pFProfileImageView.loadInBackground()
        
        
        
        return cell
        
    }


}
