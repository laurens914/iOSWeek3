//
//  ViewController.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/12/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var imagePicker = UIImagePickerController() //only var can be lazy
    var originalImage: UIImage?
    var isEdited = false
    
    @IBOutlet weak var imageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var didShow = false
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
        guard let image = self.imageView.image else {
            let alertController = UIAlertController(title: "No Image Selected", message: "please add an image", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return 
        }
        let actionSheet = UIAlertController(title: "filters", message: "please select filter", preferredStyle: .Alert)
        
        let bwAction = UIAlertAction(title: "Black & White", style: .Default) {(action) -> Void in
            Filters.bw(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.isEdited = true
            })
        }
        let monoAction = UIAlertAction(title: "Monochrome", style: .Default) {(action) -> Void in
            Filters.mono(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.isEdited = true
            })
        }
        let sepiaAction = UIAlertAction(title: "Sepia Tone", style: .Default) {(action) -> Void in
            Filters.sepia(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.isEdited = true
            })
        }
        let invertAction = UIAlertAction(title: "Invert Colors", style: .Default) {(action) -> Void in
            Filters.invert(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.isEdited = true
            })
        }
        let pixellateAction = UIAlertAction(title: "Pixellate", style: .Default) {(action) -> Void in
            Filters.pixellate(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.isEdited = true 
            })
        }
        let clampAction = UIAlertAction(title: "color clamp", style: .Default) {(action) -> Void in
            Filters.clamp(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
                self.isEdited = true
            })
        }
        let resetAction = UIAlertAction(title: "Reset", style: .Default){ (action) -> Void in
            self.imageView.image = self.originalImage
            self.isEdited = false
        }
    
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(bwAction)
        actionSheet.addAction(monoAction)
        actionSheet.addAction(sepiaAction)
        actionSheet.addAction(invertAction)
        actionSheet.addAction(pixellateAction)
        actionSheet.addAction(clampAction)
        actionSheet.addAction(resetAction)
        actionSheet.addAction(cancelAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveImage(sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image,self,"image:didFinishSavingWithError:contextInfo:", nil)
        
        if isEdited {
            API.shared.POST(Post(image: image)) { (success) -> () in
                if success {
                    print("successfully uploaded to cloudkit")
                }
            }
        } else {
            print("Not edited...")
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

}

extension ImageViewController
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]?)
    {
        self.imageView.image = image
        self.originalImage = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}













