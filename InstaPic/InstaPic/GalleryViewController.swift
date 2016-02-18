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
    @IBOutlet var collectionView: UICollectionView!
    
    var datasource = [Post]()
        {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Gallery"
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -128.0 {
            print("Show header...")
        }
    
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


