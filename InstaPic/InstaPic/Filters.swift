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
{
    static let shared = Filters()
    let context: CIContext
    
    private init ()
    {
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let EAGContext = EAGLContext(API: .OpenGLES2)
        self.context = CIContext(EAGLContext: EAGContext, options: options)
    }
    
    
    private func filter(name: String, image: UIImage, filterOptions: [String: AnyObject]? = nil, completion: FiltersCompletion)
    {
        NSOperationQueue().addOperationWithBlock{ () -> Void in
            guard let filter = CIFilter(name:name) else { fatalError("check spelling of filter") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            if let filterOptions = filterOptions{
                for (key, value) in filterOptions{
                    filter.setValue(value, forKey: key)
                }
            }
            
            //get final image
            
            guard let outputImage = filter.outputImage else { fatalError()}
            let cgImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    static var original = UIImage()
    
    func original (image: UIImage, completion: FiltersCompletion){
        completion(theImage: image)
    }
    
    func bw (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectMono", image:image, completion: completion)
    }
    func mono (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIColorMonochrome", image:image, completion: completion)
    }
    func sepia (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CISepiaTone", image:image, completion: completion)
    }
    func invert (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIColorInvert", image:image, completion: completion)
    }
    func chrome (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectChrome", image:image, completion: completion)
    }
    func vintage (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectFade", image:image, completion: completion)
    }
    func instant (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectInstant", image:image, completion: completion)
    }
    func process (image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectProcess", image:image, completion: completion)
    }
    func clamp (image:UIImage, completion: FiltersCompletion)
    {
        var filterOptions = [String: AnyObject]()
        filterOptions["inputMinComponents"] = CIVector(x:0.0, y:0.0, z:0.0,w: 0.0)
        filterOptions["inputMaxComponents"] = CIVector(x:0.7, y:0.7, z:0.7,w: 0.7)
        
        
        self.filter("CIColorClamp", image: image, filterOptions: filterOptions, completion: completion)
    }
  
}