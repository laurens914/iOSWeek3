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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Gallery"
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.update()
       
    }
    
    //hidesbaronswipe,navigationbar
    //preferredstatusbarhidden = true
    
    func update()
    {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        API.shared.getPosts{ (posts) -> () in
            if let posts = posts {
                self.datasource = posts
                self.navigationItem.rightBarButtonItem = nil 
            } else {
                print("no posts")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.datasource.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var galleryCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        galleryCell = self.datasource[indexPath.row]
    }
}
