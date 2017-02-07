//
//  CustomSignUpViewController.swift
//  Razzi
//
//  Created by Malcolm Campbell on 9/29/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse

class CustomSignUpViewController: UIViewController {

    //connects UI to code
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //declare activity spinner
    var activitySpinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets title
        self.navigationItem.title = "Sign Up"
        
        //creates activity spinner parameters
        self.activitySpinner.center = self.view.center
        self.activitySpinner.hidesWhenStopped =  true
        self.activitySpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.activitySpinner)
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
    
    //signup button function
    @IBAction func signUpAction(sender: AnyObject) {
        
        //connects UI to a constant
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        
        //if username is less than 4 spaces and/or password is less than 5 spaces
        if username!.characters.count < 4 || password!.characters.count < 5 {
            
            //show error message
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 4 and password must be greater than 5", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
        
        //else if email is less than 8 spaces
        else if email!.characters.count < 8 {
            
            //show email error message
            let alert = UIAlertView(title: "Invalid", message: "Please enter a valid email", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
        
        else {
            
            //animate the activity spinner
            self.activitySpinner.startAnimating()
            
            //declare parse user to a constant
            let newUser = PFUser()
            
            //connects parse info to a constant
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            //signup user
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                //stop activity spinner animation
                self.activitySpinner.stopAnimating()
                
                //if error
                if ((error) != nil) {
                    
                    //show error message
                    let alert = UIAlertView(title: "error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                //if no error
                else { 
                    
                    //show success message
                    let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self,    cancelButtonTitle: "OK")
                    alert.show() 
                    
                    //takes the user back to the login screen
                    self.performSegueWithIdentifier("go back", sender: self)                    
                }
                
            })
            
        }
    
    }
    
    //hides the keyboard when anything else is pressed
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
}




