//
//  Post.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/16/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit


class Post
{
    var image: UIImage
    var text: String?
    var date: NSDate?
    init(image:UIImage, text: String? = nil, date: NSDate? = nil )
    {
        self.image = image
        self.text = text
        self.date = date
    }
}
