//
//  NotificationsTableViewController.swift
//  Razzi
//
//  Created by Malcolm Campbell on 10/11/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse

class NotificationsTableViewController: UITableViewController {

    
    //Instantiates arrays
    var contentArray : NSMutableArray = NSMutableArray()
    var senderArray : NSMutableArray = NSMutableArray()
    var pfContentArray : NSMutableArray = NSMutableArray()
    
    //Occurs everytime the tab appears
    override func viewDidAppear(animated: Bool) {
        
        //Clears the objects in arrays
        senderArray.removeAllObjects()
        contentArray.removeAllObjects()
        pfContentArray.removeAllObjects()
        
        let currentUserVariable = PFUser.currentUser()
        
        let findNotificationsData = PFQuery(className: "Notifications")
        
        //Refines query search
        findNotificationsData.whereKey("receiver", equalTo: currentUserVariable!.objectId!)
        //findNotificationsData.orderByDescending("createdAt")
        //Retrieves notification data from parse.com for the reciever
        findNotificationsData.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            //If no error
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                        //Adds sender objects to array
                        self.senderArray.addObject(object.objectForKey("sender")!)
                        print(self.senderArray)
                        
                        //Adds content objects in PFFile format to array
                        self.pfContentArray.addObject(object.objectForKey("content")!)
                        
                        //Finds PFFile object in database
                        let userPicture = object["content"] as! PFFile
                        userPicture.getDataInBackgroundWithBlock({
                            (imageData: NSData?, error: NSError?) -> Void in
                            if (error == nil) {
                                
                                //Converts PFFile to UIImage
                                let image = UIImage(data:imageData!)
                                
                                
                                
                                //Adds converted content to array
                                self.contentArray.addObject(image!)
                                
                            }
                        //Displays new data in tableView
                    self.tableView.reloadData()
                            //location of reloadData (maybe begining of something
                            //location of orderbydescending
                            //maybe name object something different
                            
                        })
                        
                    }
                
                }
                
            }
            
            else {
                
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        //Determines the amount of sections
        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Determines the amount of cell rows
        return self.contentArray.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Creates a constant and connects it to table View cell
        let cell = tableView.dequeueReusableCellWithIdentifier("NotificationCell", forIndexPath: indexPath) as! NotificationsTableViewCell
        
        //Displays chosen image in the cell
        cell.notificationsImageView.image = contentArray.objectAtIndex(indexPath.row) as? UIImage
        
        cell.yesButton.tag = indexPath.row
        
        //Adds an action to this cell button
        cell.yesButton.addTarget(self, action: #selector(NotificationsTableViewController.logAction(_:)), forControlEvents: .TouchUpInside)
        
        
        
        return cell
    }
    
    @IBAction func logAction(sender: UIButton){
        
        //Connects variable to a class in database
        let content = PFObject(className: "Content")
        
        //Adds data to database
        content["user"] = PFUser.currentUser()
        content["submitter"] = self.senderArray.objectAtIndex(sender.tag) as! PFUser
        content["content"] = self.pfContentArray.objectAtIndex(sender.tag) as! PFFile
        content.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            
            if (success){
                
                //Alerts User that request has been sent
                let alertMessage = UIAlertView(title: "Content Added", message: "Your timeline has been updated", delegate: self, cancelButtonTitle: "OK")
                
                alertMessage.show()
                
                //turns off button functionality
                sender.enabled = false
                
            }
            
            else {
                
            }
        
        }
        
        self.tableView.deselectRowAtIndexPath(NSIndexPath(), animated: true)
        
    }
    
    //@IBOutlet var notificationsTableView: UITableView!
    
    
    

}










