//
//  FollowTableViewController.swift
//  Razzi
//
//  Created by Malcolm Campbell on 1/6/16.
//  Copyright (c) 2016 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse

class FollowTableViewController: UITableViewController, UISearchResultsUpdating {
    
    //Declare variables
    var query = PFUser.query()
    
    var allUsernamesArray:NSMutableArray = NSMutableArray()
    var receiverIDArray:NSMutableArray = NSMutableArray()
    
    var filteredUsernamesArray = [String]()
    
    var followSearchController = UISearchController() 
    
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        
        let alertMessage = UIAlertView(title: "Follow Tab", message: "Search for a user in the search bar, then tap their name to follow them", delegate: self, cancelButtonTitle: "OK")
        alertMessage.show()
    
        
        //Clears data from all arrays
        allUsernamesArray.removeAllObjects()
        receiverIDArray.removeAllObjects()
        
        //Retrieves objects from parse.com
        query!.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            //If no errors
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        print(object.objectForKey("username"))
                        
                        //Add objects to these arrays
                        self.allUsernamesArray.addObject(object.objectForKey("username")!)
                        self.receiverIDArray.addObject(object)
                        self.tableView.reloadData()
                    }
                }
            }
                
                //If errors occur
            else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        //Declare the UISearchController
        self.followSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            controller.searchBar.placeholder = "Find Users to Follow"
            
            return controller
        })()
        
        //Reloads the table
        self.tableView.reloadData()
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        //Detemines the amount of sections
        return 1
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Determines the amount of cell rows
        if (self.followSearchController.active) {
            
            //Return as many rows as there are filtered usernames
            return self.filteredUsernamesArray.count
            
        }
            
        else {
            
            //Return as many rows as there are users
            return self.allUsernamesArray.count
            
        }
        
    }
    
    //Cell at the current index function
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Declare a constant that connects to the storyboard cell named FollowCell
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowCell", forIndexPath: indexPath)
        
        //If followSearchController is active
        if (self.followSearchController.active) {
            
            //Display filtered usernames from array onto each cell
            cell.textLabel?.text = filteredUsernamesArray[indexPath.row]
            return cell
        }
            
        //Else if not active
        else {
            
            //Displays all usernames onto each cell
            cell.textLabel?.text = allUsernamesArray[indexPath.row] as? String
            return cell
        }
    }
    
    //updateSearchResultsForSearchController function
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        //Clear filteredUsernamesArray
        filteredUsernamesArray.removeAll(keepCapacity: false)
        
        //Updates search results
        let searchPredicate = NSPredicate(format: "SELF CONTAINS [c] %@",  searchController.searchBar.text!)
        let array = (allUsernamesArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredUsernamesArray = array as! [String]
        
        //Reload data
        self.tableView.reloadData()
        
    }
    
    //After selecting cell at current index function
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(NSIndexPath(), animated: true)
        
        //Creates parse object
        let follow = PFObject(className: "Follow")
        
        //Adds new data to parse.com
        follow["follower"] = PFUser.currentUser()
        follow["leader"] = receiverIDArray[indexPath.row]
        follow.saveInBackgroundWithBlock{
            (success: Bool, error: NSError?) -> Void in
            if (success){
                
                //Alerts User that request has been sent
                let alertMessage = UIAlertView(title: "Now Following", message: "You are now following this user and will be updated with their activity", delegate: self, cancelButtonTitle: "OK")
                
                alertMessage.show()
                
                //Goes back to Events tab
                self.performSegueWithIdentifier("login", sender: self)
                
            }
                
            else{
                
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                
            }
            
        }
        
    }
    
}
