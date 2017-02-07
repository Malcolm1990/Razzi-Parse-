//
//  PFNewsFeedTableViewController.swift
//  Razzi
//
//  Created by Marvin Campbell on 1/7/16.
//  Copyright (c) 2016 Malcolm Campbell. All rights reserved.
//

//import libraries
import UIKit
import Parse
import ParseUI
import Bolts


class PFNewsFeedTableViewController: PFQueryTableViewController {
    
    /*override func viewDidLoad() {
        let alertMessage = UIAlertView(title: "News Feed Tab", message: "This tab shows the photos from the users you follow", delegate: self, cancelButtonTitle: "OK")
        alertMessage.show() 
    }*/
     
    //Declare a query function
    override func queryForTable() -> PFQuery {
        
        //Declare findleaders as the constant for the query out of the class named "Follow"
        //Inside findLeaders, locate where the key "follower" is equal to the current user
        //Order the Array by descending order
        let findLeaders = PFQuery(className: "Follow")
        findLeaders.whereKey("follower", equalTo: PFUser.currentUser()!)
        findLeaders.orderByDescending("createdAt")
        
        //Declare findContent as the constant for the query out of the class named “Content”
        //Inside findContent, locate where the key “user”, matches the key “leader” in the query “findLeaders"
        //Order the array by descending order
        let findContent = PFQuery(className: "Content")
        findContent.whereKey("user", matchesKey: "leader", inQuery: findLeaders)
        findContent.orderByDescending("createdAt")
        
        return findContent
    }
   
    
    //Cell at the current index function
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        //Declare cell = to the storyboard cell
        let cell = tableView.dequeueReusableCellWithIdentifier("PFNewsFeedCell", forIndexPath: indexPath) as! PFNewsFeedTableViewCell
        
        //Declare imageConstant = to the queried object at the current index
        let imageConstant = object?.objectForKey("content") as? PFFile
        //Connect constant to storyboard imageView
        cell.pFNewsFeedView.image = UIImage(named: "placeholder")
        cell.pFNewsFeedView.file = imageConstant
        cell.pFNewsFeedView.loadInBackground()
        
        //Make the text labels equal to the username and submitter at the current index
        cell.userLabel.text = object?.objectForKey("userName") as? String
        cell.submitterLabel.text = object?.objectForKey("submitterName") as? String
        
        return cell
        
    }
    
    
    
    
    
    
    
    
   
    
    

}
