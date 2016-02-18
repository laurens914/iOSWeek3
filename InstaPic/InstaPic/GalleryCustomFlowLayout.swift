//
//  GalleryCustomFlowLayout.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/17/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class GalleryCustomFlowLayout: UICollectionViewFlowLayout
{
    var columns: Int
    let spacing: CGFloat = 1.0
    init(columns: Int = 3)
    {
        self.columns = columns
        super.init()
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()
    {
        self.minimumLineSpacing = self.spacing
        self.minimumInteritemSpacing = self.spacing
        self.itemSize = CGSize(width: self.itemWidth(), height: self.itemWidth()*1.5)
    }
    
    func screenWidth() -> CGFloat
    {
        return CGRectGetWidth(UIScreen.mainScreen().bounds)
    }
    func itemWidth() -> CGFloat
    {
        let width = self.screenWidth()
        let availableWidth = width - (CGFloat(self.columns) * self.spacing)
        return availableWidth/CGFloat(self.columns)
    }
}
