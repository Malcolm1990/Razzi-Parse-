//
//  RequestUserTableViewController.swift
//  Razzi
//
//  Created by Malcolm Campbell on 10/7/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse

class RequestUserTableViewController: UITableViewController, UISearchResultsUpdating {

    //Declare variables
    var query = PFUser.query()
    
    var allUsernamesArray:NSMutableArray = NSMutableArray()
    var receiverIDArray:NSMutableArray = NSMutableArray()
    
    var filteredUsernamesArray = [String]()
    
    var resultSearchController = UISearchController()
    
    var chosenContent = PFFile()
    
    var userName = PFUser.currentUser()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Request"
        
        let alertMessage = UIAlertView(title: "Request", message: "Search for a user in the search bar, then tap their name to send the picture to them", delegate: self, cancelButtonTitle: "OK")
        alertMessage.show()
    

        //Clears data from arrays
        allUsernamesArray.removeAllObjects()
        receiverIDArray.removeAllObjects()
        
        //Retrieves objects from parse.com database
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
                        self.receiverIDArray.addObject(object.objectId!)
                        self.tableView.reloadData()
                    }
                }
            }
            
            //else if errors occur
            else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        //Declare the UISearchController
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            
            //Specify parameters
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            controller.searchBar.placeholder = "Search Users"
            
            return controller
        })()
        
        // Reloads the table
        self.tableView.reloadData()
    }

    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        //detemines the amount of sections
        return 1
    
    }

   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //If followSearchController is active
        if (self.resultSearchController.active) {
            
            // return as many rows as there are filtered usernames
            return self.filteredUsernamesArray.count
        }
        
        //Else if not active
        else {
            
            //return as many rows as there are users
            return self.allUsernamesArray.count
        }
    
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //declare a constant that connects to the storyboard cell called requestUserCell
        let cell = tableView.dequeueReusableCellWithIdentifier("RequestUserCell", forIndexPath: indexPath)
        
        //If resultSearchController is active
        if (self.resultSearchController.active) {
            
            //Displays filtered usernames from array onto each cell
            cell.textLabel?.text = filteredUsernamesArray[indexPath.row]
            return cell
        }
            
        //else if not active
        else {
            
            //Displays all usernames onto each cell
            cell.textLabel?.text = allUsernamesArray[indexPath.row] as? String
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        //Clears array
        filteredUsernamesArray.removeAll(keepCapacity: false)
        
        //Updates search results
        let searchPredicate = NSPredicate(format: "SELF CONTAINS [c] %@",  searchController.searchBar.text!)
        let array = (allUsernamesArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredUsernamesArray = array as! [String]
        
        //reload data
        self.tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Declare a variable that connects to the requestUserCell
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        //Declare parse object
        let notification = PFObject(className: "Notifications")
        
        //Converts username object to string
        let convertedName = userName?.objectForKey("username") as? String
        
        //if cell.textLabel.text is equal to current username
        if cell.textLabel?.text == convertedName {
            
            //Declare alert message
            let alertMessage = UIAlertView(title: "Oops!", message: "You can't request content to yourself. Please try another username.", delegate: self, cancelButtonTitle: "OK")
            
            //show alert message
            alertMessage.show()
            
        }
        
        //Else if cell.textLabel.text is not equal to current username
        else{
            
            //Adds new data to parse.com database
            notification["sender"] = PFUser.currentUser()
            notification["receiver"] = receiverIDArray[indexPath.row]
            notification["content"] = chosenContent
            notification["senderName"] = userName?.objectForKey("username")
            notification.saveInBackgroundWithBlock{
                (success: Bool, error: NSError?) -> Void in
            
                //if successful
                if (success){
                
                    //Declare alert message
                    let alertMessage = UIAlertView(title: "Request Sent", message: "Your request has been sent  to this users notification feed", delegate: self, cancelButtonTitle: "OK")
                    
                    //Alerts User that request has been sent
                    alertMessage.show()
        
                    //Goes back to Events tab
                    self.performSegueWithIdentifier("login", sender: self)
                
                }
            
                //Else if not successful
                else {
               
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
            
                }
            }
        }
        
        tableView.deselectRowAtIndexPath(NSIndexPath(), animated: true)

    }
    
}
