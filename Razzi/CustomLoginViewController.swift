//
//  CustomLoginViewController.swift
//  Test
//
//  Created by Malcolm Campbell on 5/1/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse

class CustomLoginViewController: UIViewController {
    
    //Connects the UI to the code
    @IBOutlet weak var usernameTextField: UITextField! 
    @IBOutlet weak var passwordTextField: UITextField!  
    
    //Declares an activity spinner
    var activitySpinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //change the color of the navigation bars to orange
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 173.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        
        
        //creates the activity spinner parameters
        self.activitySpinner.center = self.view.center
        self.activitySpinner.hidesWhenStopped =  true
        self.activitySpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.activitySpinner)
        
        
        passwordTextField.returnKeyType = .Done
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to  do a little preperation before navigation
     override func prepareForSeque(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: Actions
    
    //creates login button function
    @IBAction func whenPressesLogin(sender: AnyObject) {
        
        //connects UI to constant
        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        
        //if username is less than 4 spaces and/or password is less than 5 spaces
        if username!.characters.count < 4 || password!.characters.count < 5 {
            
            //show error message
            let alertMessage = UIAlertView(title: "Invalid", message: "Username needs to be greater than 4 letters long and Password needs to be greater than 5 letters long", delegate: self, cancelButtonTitle: "OK")
            
            alertMessage.show()
            
        }
            
        else {
            
            //animate the activity spinner
            self.activitySpinner.startAnimating()
            
            //log the user in
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) ->
                Void in
                
                //stop activity spinner animation
                self.activitySpinner.stopAnimating()
                
                //if successful
                if ((user) != nil) {
                    
                    //show login message
                    let alertMessage = UIAlertView(title: "Successful Login", message: "Welcome to Razzi", delegate: self, cancelButtonTitle: "Enter")
                    alertMessage.show()
                    
                    //Takes successful sign in to users profile
                    self.performSegueWithIdentifier("login", sender: self)
                    
                }
                
                //if it fails
                else {
                    
                    //show error message
                    let alertMessage = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alertMessage.show()
                    
                }
                
            })
            
        }
        
        //hides the keyboard when the login button is pressed
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
    }
    
    //Goes to the sign up page
    @IBAction func whenUserPressesSignUp(sender: AnyObject) {
        
        self.performSegueWithIdentifier("signup", sender: self)
        
    }
    
    //logs the user out
    @IBAction func whenUserPressesLogout(sender: AnyObject) {
        
        PFUser.logOut()
        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
        
    }
    
    //hides the keyboard when anything else is pressed
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    
}

