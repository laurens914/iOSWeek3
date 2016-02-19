//
//  ControllerAdditions.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/18/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

extension FiltersPreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let filterCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        let datasource = self.dataSource[indexPath.row]
        
        datasource(self.image, completion:{filterCell.imageView.image = $0})
        
        return filterCell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("got here")
        guard let filterCell = collectionView.cellForItemAtIndexPath(indexPath) as? GalleryCollectionViewCell else {return}
        self.delegate?.previewViewControllerDidFinish(filterCell.imageView.image!)
        dismissViewControllerAnimated(true, completion: nil)
    }
}


