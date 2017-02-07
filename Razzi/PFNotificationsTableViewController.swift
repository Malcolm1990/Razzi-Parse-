//
//  PFNotificationsTableViewController.swift
//  Razzi
//
//  Created by Marvin Campbell on 12/8/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse
import ParseUI



class PFNotificationsTableViewController: PFQueryTableViewController {
    
    //Declare variable
    var user = PFUser.currentUser()
    
    /*override func viewDidLoad() {
        let alertMessage = UIAlertView(title: "Notifications Tab", message: "This tab shows the photos that other users sent to you", delegate: self, cancelButtonTitle: "OK")
        alertMessage.show()
    }*/
    
    
    override func queryForTable() -> PFQuery {
        
        //Declare constant and connect it to query class
        let findNotificationsData = PFQuery(className: "Notifications")

        //refine query
        findNotificationsData.whereKey("receiver", equalTo: user!.objectId!)
        
        //order found objects in descending order
        findNotificationsData.orderByDescending("createdAt")
        
        return findNotificationsData
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        //Declare constant and connect it to the storyboard cell
        let cell = tableView.dequeueReusableCellWithIdentifier("PFNotificationsCell", forIndexPath: indexPath) as! PFNotificationsTableViewCell
        
        //Declare constant and connect it to the queried object
        let imageConstant = object?.objectForKey("content") as? PFFile
        
        //Connect constant to storyboard imageView
        cell.pFNotificationsImageView.image = UIImage(named: "placeholder")
        cell.pFNotificationsImageView.file = imageConstant
        cell.pFNotificationsImageView.loadInBackground()
        
        //Adds an action to this cell button
        cell.yesButton.addTarget(self, action: #selector(PFNotificationsTableViewController.logAction(_:)), forControlEvents: .TouchUpInside)
        
        return cell
   
    }
    
    
   
    
    //Added action to the cell button function
    @IBAction func logAction(sender: UIButton){
        
        //declares a constant for the current touch point on the tableview
        let point = sender.convertPoint(CGPointZero, toView : tableView)
        
        //determines which cell is at that point and creates a constant for it
        let indexPath = self.tableView.indexPathForRowAtPoint(point)
        
        //Delares and connects constant to a class in the database
        let theObject = self.objectAtIndexPath(indexPath)
        
        //println(self.objects)
        print(theObject)
        
        
        //Connects variable to a class in database
        let content = PFObject(className: "Content")
        
        //Adds data to database
        content["user"] = PFUser.currentUser()
        content["submitter"] = theObject?.objectForKey("sender")
        content["content"] = theObject?.objectForKey("content")
        content["submitterName"] = theObject?.objectForKey("senderName")
        content["userName"] = user?.objectForKey("username")
        content.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            
            //if successful
            if (success){
                
                //Declare alert message
                let alertMessage = UIAlertView(title: "Content Added", message: "Your timeline has been updated", delegate: self, cancelButtonTitle: "OK")
                
                //Alerts User that request has been sent
                alertMessage.show()
                
                //turns off button functionality
                sender.enabled = false
                
            }
             
            //Else if not successful
            else {
                
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
        
        self.tableView.deselectRowAtIndexPath(NSIndexPath(), animated: true)
        
    }
    
    
    
    
    
    
}
