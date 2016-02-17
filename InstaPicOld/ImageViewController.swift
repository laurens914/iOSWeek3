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
            self.presentImagePicker(.Camera)
            self.presentImagePicker(.PhotoLibrary)
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
        
    }
}

extension ImageViewController
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]?)
    {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
