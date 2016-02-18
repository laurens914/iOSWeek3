//
//  GalleryCollectionViewCell.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/17/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell, Identity
{
    @IBOutlet weak var imageView: UIImageView!
    
    class func id() -> String
    {
        return "GalleryViewController"
    }
    
    var post: Post? {
        didSet{
            self.imageView.image = self.post?.image
        }
    }
    
    
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}
