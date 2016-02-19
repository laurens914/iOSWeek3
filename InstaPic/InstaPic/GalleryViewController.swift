//
//  GalleryViewController.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/17/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController
{
    
    @IBOutlet weak var collectionView: UICollectionView!
      
    
    var datasource = [Post]()
        {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Gallery"
        self.collectionView.collectionViewLayout = small
        self.navigationController?.hidesBarsOnSwipe = true
        //self.scrollsToTop = true
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.update()
        
    }
    

    
    func update()
    {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        API.shared.getPosts{ (posts) -> () in
            if let posts = posts {
                self.datasource = posts
                print(posts)
                self.navigationItem.rightBarButtonItem = nil
            } else {
                print("no posts")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
      
    
    let small = GalleryCustomFlowLayout(columns: 3)
    let medium = GalleryCustomFlowLayout(columns: 2)
    let large = GalleryCustomFlowLayout(columns: 1)
    
    var postPinchTransiionCompleted = true
    var pinchDirectionDetermined = false
    var initalPinchScale: CGFloat = 0.0
    var pinchPoint: CGFloat = 0.0
    
    
    
    @IBAction func pinchGesture(sender: UIPinchGestureRecognizer) {
        if sender.state == .Began {
            
            
            
            if sender.velocity > 0 && self.collectionView.collectionViewLayout == self.small {
                
                self.animate(self.medium)
            
                
            } else if sender.velocity > 0 && self.collectionView.collectionViewLayout == self.medium {
                
                self.animate(self.large)
            }
            
            if sender.velocity < 0 && self.collectionView.collectionViewLayout == self.large {
                
                self.animate(self.medium)
            } else if sender.velocity < 0 && self.collectionView.collectionViewLayout == self.medium {
                
                self.animate(self.small)
                
            }
        }
    }
    
    func animate(layout: GalleryCustomFlowLayout)
    {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { () -> Void in
            self.collectionView.collectionViewLayout = layout
            }, completion: nil)
    }
    
}


extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
        }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let galleryCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        galleryCell.post = self.datasource[indexPath.row]
        return galleryCell 
    }
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return true
    }
}


