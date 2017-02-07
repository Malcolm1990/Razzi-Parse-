//
//  ProfileTableViewController.swift
//  Razzi
//
//  Created by Marvin Campbell on 10/23/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse

class ProfileTableViewController: UITableViewController{
    
    var contentArray: NSMutableArray = NSMutableArray()
    
    //occurs everytime the tab appears
    override func viewDidAppear(animated: Bool) {
        
        contentArray.removeAllObjects()
        
        _ = PFUser.currentUser()
        
        //Retrieves content data from parse.com for the reciever
        let findContentData = PFQuery(className: "Content")
        findContentData.whereKey("user", equalTo: PFUser.currentUser()!)
        findContentData.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            //If no error
            if error == nil {
                
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                
                // Do something with the found object
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                        //Finds PFFile object in database
                        let userPicture = object["content"] as! PFFile
                        userPicture.getDataInBackgroundWithBlock({
                            (imageData: NSData?, error: NSError?) -> Void in
                            if (error == nil) {
                                
                                //Converts PFFile into UIImage
                                let image = UIImage(data:imageData!)
                                
                                //Adds converted content to array
                                self.contentArray.addObject(image!)
                                
                            }
                            
                        //Displays new data in tableView    
                        self.tableView.reloadData()
                            
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // Return the number of sections.
        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of rows in the section.
        return self.contentArray.count
        
    }
    
   /* override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("ProfileHeaderCell") as! ProfileHeaderTableViewCell
        
        
        return headerCell
    }*/

    
    //@IBOutlet var profileTableView: UITableView!
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileTableViewCell
        
        cell.profileImageView.image = contentArray.objectAtIndex(indexPath.row) as? UIImage

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
