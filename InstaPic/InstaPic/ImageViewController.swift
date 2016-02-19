//
//  ViewController.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/12/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit
import Social

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FilterPreviewDelegate {
    
    lazy var imagePicker = UIImagePickerController() //only var can be lazy
    var originalImage: UIImage?
    var isEdited = false
    var didShow = false
    
    func previewViewControllerDidFinish(image: UIImage)
    {
        self.imageView.image = image
    }
    
    @IBOutlet weak var imageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType)
    {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func presentActionSheet ()
    {
        let actionSheet = UIAlertController(title: "Source", message: "Please select the source type", preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction( title:"Camera", style: .Default) { (action) -> Void in
            self.presentImagePicker(.Camera)
        }
        let photoAction = UIAlertAction( title:"Photo Library", style: .Default) { (action) -> Void in
            self.presentImagePicker(.PhotoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
   
    @IBAction func addImage(sender: AnyObject) {
    if UIImagePickerController.isSourceTypeAvailable(.Camera){
            presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
        
    }
    
    
    
    @IBAction func editImage(sender: AnyObject) {
        guard let _ = self.imageView.image else {
            let alertController = UIAlertController(title: "No Image Selected", message: "please add an image", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return 
        }
        
        performSegueWithIdentifier("showFilters", sender: self)
    
        
    }
    
    
    @IBAction func saveImage(sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image,self,"image:didFinishSavingWithError:contextInfo:", nil)
        
        
            API.shared.POST(Post(image: image)) { (success) -> () in
                if success {
                    print("successfully uploaded to cloudkit")
                }
            }
        }
    
    func image(image:UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>)
    {
        if error == nil {
            let alertController = UIAlertController(title:"saved", message: "your image has been save to photos", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func deleteImage(sender: AnyObject)
    {
        guard let _ = self.imageView.image else {return}
        
        let alertController = UIAlertController(title: "About to Delete Image", message: "press ok to continue", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
                self.imageView.image = nil
                self.originalImage = nil
            })
        self.presentViewController(alertController, animated: true, completion: nil)
       
       
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as! FiltersPreviewViewController
        destinationViewController.image = self.imageView.image
        previewViewControllerDidFinish(destinationViewController.image)
        destinationViewController.delegate = self 
        
    }
    

    
    
    @IBAction func share(sender: UIBarButtonItem) {
        if imageView.image == nil {
            let alertController = UIAlertController(title: "No Image Selected", message: "please add an image", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if let image  = self.imageView.image {
            let actionSheet = UIAlertController(title: "Social Sharing", message: "Choose where to upload", preferredStyle: .ActionSheet)
            let facebookAction = UIAlertAction(title: "facebook", style: .Default, handler: { (action) -> Void in
                let serviceTypeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                serviceTypeVC.addImage(image)
                self.presentViewController(serviceTypeVC, animated:true, completion: nil)
                
            })
            let twitterAction = UIAlertAction(title: "twitter", style: .Default, handler: { (action) -> Void in
                let serviceTypeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                serviceTypeVC.addImage(image)
                self.presentViewController(serviceTypeVC, animated:true, completion: nil)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            actionSheet.addAction(facebookAction)
            actionSheet.addAction(twitterAction)
            actionSheet.addAction(cancelAction)
            self.presentViewController(actionSheet, animated: true, completion: nil)
        }
 
    }
    

}

extension ImageViewController
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]?)
    {
        let resizedImage = UIImage.resize(image, size: CGSize(width: image.size.width/2, height: image.size.height/2))
        self.imageView.image = resizedImage
        self.originalImage = resizedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
}













