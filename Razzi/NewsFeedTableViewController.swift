//
//  NewsFeedTableViewController.swift
//  Razzi
//
//  Created by Marvin Campbell on 1/7/16.
//  Copyright (c) 2016 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse

class NewsFeedTableViewController: UITableViewController {
    
    var leadersArray : NSMutableArray = NSMutableArray()
    var contentArray : NSMutableArray = NSMutableArray()
    var usersFromContentArray : NSMutableArray = NSMutableArray()
    
    var indexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leadersArray.removeAllObjects()
        
        let findLeaders = PFQuery(className: "Follow")
        
        findLeaders.whereKey("follower", equalTo: PFUser.currentUser()!)
        findLeaders.orderByDescending("createdAt")
        findLeaders.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            //If no error
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) leaders.")
                
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    
                    for object in objects {
                        
                        self.leadersArray.addObject(object.objectForKey("leader")!)
                    
                    }
                    print("leadersArray is")
                    print(self.leadersArray)
                    
                    
                    
                   
                    
                }
                
            }
            
        }
        
    }

    override func viewDidAppear(animated: Bool) {
        
        contentArray.removeAllObjects()
        
       /* for object in self.leadersArray {*/
            
                        //let pFLeader:PFObject = self.leadersArray.objectAtIndex(self.indexPath) as! PFObject
            
                        let findContent = PFQuery(className: "Content")
                        
                        findContent.whereKey("user", containedIn: self.leadersArray as [AnyObject])
                        findContent.orderByDescending("createdAt")
                        findContent.findObjectsInBackgroundWithBlock {
                            (theObjects: [AnyObject]?, error: NSError?) -> Void in
                            
                            //If no error
                            if error == nil {
                                
                                print("Successfully retrieved \(theObjects!.count) contents.")
                                
                                // Do something with the found objects
                                if let theObjects = theObjects as? [PFObject] {
                                    
                                    for object in theObjects {
                                        
                                        //Finds PFFile object in database
                                        let userPicture = object["content"] as! PFFile
                                        userPicture.getDataInBackgroundWithBlock({
                                            (imageData: NSData?, error: NSError?) -> Void in
                                            
                                            if (error == nil){
                                                
                                                //Converts PFFile to UIImage
                                                let image = UIImage(data:imageData!)
                                            
                                               self.contentArray.addObject(image!)
                                            
                                            }
                                            
                                            self.tableView.reloadData()
                                            
                                        })
                                        
                                        
                                        self.usersFromContentArray.addObject("query the username to content class")
                                        print(self.contentArray)
                                    }
                                    
                                }
                            }
                        }
                        /*println("object at index is")
                        println(self.leadersArray.objectAtIndex(self.indexPath))
                        
                        println(self.indexPath)
                        
                        self.indexPath = self.indexPath + 1*/
                
            /*}
        println("contentArray is")
        println(self.contentArray)*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.contentArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsFeedCell", forIndexPath: indexPath) as! NewsFeedTableViewCell

        cell.newsFeedView.image = contentArray.objectAtIndex(indexPath.row) as? UIImage
        
        cell.userLabel.text = usersFromContentArray.objectAtIndex(indexPath.row) as? String

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
