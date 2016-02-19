//
//  FiltersPreviewViewController.swift
//  InstaPic
//
//  Created by Lauren Spatz on 2/18/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit
protocol FilterPreviewDelegate: class
{
    func previewViewControllerDidFinish(image: UIImage)
}
class FiltersPreviewViewController: UIViewController
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var image: UIImage!
   
    weak var delegate: FilterPreviewDelegate? 
    
    
    var dataSource = [Filters.shared.original,Filters.shared.bw, Filters.shared.mono, Filters.shared.sepia, Filters.shared.invert, Filters.shared.clamp, Filters.shared.chrome, Filters.shared.vintage, Filters.shared.instant, Filters.shared.process]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


