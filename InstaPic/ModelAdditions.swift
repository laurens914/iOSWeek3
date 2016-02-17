//
//  ModelAdditions.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/16/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit
import CloudKit

enum PostError: ErrorType
{
    case wrtitingImage
    case CreatingCKRecord
}

extension Post
{
    class func recordWith(post: Post) throws -> CKRecord?
    {
        let imageURL = NSURL.imageURL()
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else {throw PostError.wrtitingImage}
        let saved = data.writeToURL(imageURL, atomically: true)
        
        if saved{
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: "Post")
            record.setObject(asset, forKey: "image")
            
            return record
        } else { throw PostError.CreatingCKRecord}
    }
}