//
//  Filters.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/16/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit
typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters
{//create a way to hold onto original image
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion, filterOptions: [String: AnyObject]? = nil)
    {
        NSOperationQueue().addOperationWithBlock{ () -> Void in
            guard let filter = CIFilter(name:name) else { fatalError("check spelling of filter") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            if let filterOptions = filterOptions{
                for (key, value) in filterOptions{
                    filter.setValue(value, forKey: key)
                }
            }
//            filter.setDefaults()
            //GPU Context
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let EAGContext = EAGLContext(API: .OpenGLES2)
            let GPUContext = CIContext(EAGLContext: EAGContext, options: options)
            
            //get final image
            
            guard let outputImage = filter.outputImage else { fatalError()}
            let cgImage = GPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    class func bw (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectMono", image:image, completion: completion)
    }
    class func mono (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIColorMonochrome", image:image, completion: completion)
    }
    class func sepia (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CISepiaTone", image:image, completion: completion)
    }
    class func invert (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIColorInvert", image:image, completion: completion)
    }
    class func pixellate (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPixellate", image:image, completion: completion)
    }
    class func clamp (image:UIImage, completion: FiltersCompletion)
    {
        var filterOptions = [String: AnyObject]()
        filterOptions["inputMinComponents"] = CIVector(x:0.0, y:0.0, z:0.0,w: 0.0)
        filterOptions["inputMaxComponents"] = CIVector(x:0.5, y:0.5, z:0.5,w: 0.5)
        
        
        self.filter("CIColorClamp", image: image, completion: completion, filterOptions: filterOptions)
    }
  
}




//let filterNames = CIFilter.filterNamesInCategory(kCICa...