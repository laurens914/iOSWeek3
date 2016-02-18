//
//  Additions.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/16/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit


extension UIImage
{
    class func resize(image: UIImage, size: CGSize) -> UIImage
    {
        print(image.size)
        print(size)
        UIGraphicsBeginImageContext(size)
        let rect = CGRect(x:0.0 , y: 0.0, width: size.width, height: size.height)
        image.drawInRect(rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}

extension NSURL{
    class func imageURL() -> NSURL
    {
        guard let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else { fatalError()}
        return documentsDirectory.URLByAppendingPathComponent("image")
    }
}

