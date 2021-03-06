//
//  ViewController.swift
//  Razzi
//
//  Created by Malcolm Campbell on 9/28/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse
/*import ParseUI*/

class ViewController: UIViewController/*, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate*/{

   /* var logInViewController: PFLogInViewController! = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
       /* if (PFUser.currentUser() == nil) {
            self.logInViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten | PFLogInFields.DismissButton
            
            var logInLogoTitle = UILabel()
            logInLogoTitle.text = "Razzi"
            
            self.logInViewController.logInView?.logo = logInLogoTitle
            
            self.logInViewController.delegate = self
            
            var signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "Razzi"
            
            self.signUpViewController.signUpView?.logo = signUpLogoTitle
            
            self.signUpViewController.delegate = self
            
            self.logInViewController.signUpController = self.signUpViewController
            
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Parse Login
    
   /* func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        // vea software 12:20
        if (!username.isEmpty || !password.isEmpty) {
            return true
        }
        
        else {
            return false
        }
        
    }

    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
         self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("login", sender: self)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("Failed to login")
    }
    
    // MARK: Parse Sign Up
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("Failed to sign up.")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("User dimissed sign up.")
    }
    
    
    // MARK: Actions
    
    @IBAction func simpleAction(sender: AnyObject) {
    
    self.presentViewController(self.logInViewController, animated: true, completion: nil)
    }*/
    
    @IBAction func whenUserPressesLoginScreen(sender: AnyObject) {
    
        self.performSegueWithIdentifier("custom", sender: self)
        
    }
    
    @IBAction func whenUserPressesLogout(sender: AnyObject) {
        
        PFUser.logOut()
        
    }
    
}




















