//
//  EventsViewController.swift
//  Razzi
//
//  Created by Malcolm Campbell on 10/7/15.
//  Copyright (c) 2015 Malcolm Campbell. All rights reserved.
//

import UIKit
import Parse


class EventsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let alertMessage = UIAlertView(title: "Events Tab", message: "Take a photo then request it to a user", delegate: self, cancelButtonTitle: "OK")
        alertMessage.show()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    
    @IBAction func whenUserPressesTakePhoto(sender: AnyObject) {
        
        //goes to your phone camera
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func whenUserPressesSelectFromPhotoLibrary(sender: AnyObject) {
        
        //goes to your photo library
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func whenUserPressesRequestEvent(sender: AnyObject) {
        
        //Goes to the search screen
        self.performSegueWithIdentifier("request", sender: self)
        
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    var outsideVarImageFile = PFFile()
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //converts selected image and displays onto UIImageView
        imageViewOutlet.image = info [UIImagePickerControllerOriginalImage] as? UIImage
        let pickedImage:UIImage = (info [UIImagePickerControllerOriginalImage] as? UIImage)!
        let imageData = pickedImage.lowestQualityJPEGNSData
        
        //converts image to PFFile and returns as a variable
        let imageFile = PFFile(name:"image.png", data:imageData)
        outsideVarImageFile = imageFile
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: More override func
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Transfers chosen image data to the next view controller
        let destViewController : RequestUserTableViewController = segue.destinationViewController as! RequestUserTableViewController
        destViewController.chosenContent = outsideVarImageFile
        
    }

}

//Compresses the image data to JPEG
extension UIImage {
    var uncompressedPNGData: NSData      { return UIImagePNGRepresentation(self)!        }
    var highestQualityJPEGNSData: NSData { return UIImageJPEGRepresentation(self, 1.0)!  }
    var highQualityJPEGNSData: NSData    { return UIImageJPEGRepresentation(self, 0.75)! }
    var mediumQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.5)!  }
    var lowQualityJPEGNSData: NSData     { return UIImageJPEGRepresentation(self, 0.25)! }
    var lowestQualityJPEGNSData:NSData   { return UIImageJPEGRepresentation(self, 0.0)!  }
}
