//
//  PuzzleCollectionViewController.swift
//  CollectionViewCatPicPuzzle
//
//  Created by Joel Bell on 10/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import GameplayKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
   // PROPERTIES
    
    var headerReusableView: HeaderReusableView!
    var footerReusableView: FooterReusableView!
    
    var sectionInsets: UIEdgeInsets!
    var spacing: CGFloat!
    var itemSize: CGSize!
    var referenceSize: CGSize!
    var numberofRows: CGFloat!
    var numberofColumns: CGFloat!
    
    
    var imageSlices = [UIImage]()
    
    
    //ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.collectionView?.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        self.collectionView?.register(FooterReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        configureLayout()
        
        for i in 1...12 {
            imageSlices.append(UIImage(named: String(i))!)
        }
       
        imageSlices = randomizeImages(images: imageSlices)
    
        
    }
    
    
    
    // This function will give values to various properties related to the view. These properties must have values before flow layout methods are called.

    func configureLayout() {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        spacing = 2
        numberofRows = 4
        numberofColumns = 3
        referenceSize = CGSize(width: screenWidth, height: 60)
        sectionInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let widthDeduction = sectionInsets.left + sectionInsets.right + spacing * (numberofColumns - 1)
        let heightDeduction = sectionInsets.top + sectionInsets.bottom + spacing * (numberofRows - 1)
        
        let widthDeductionPerItem = (screenWidth - widthDeduction) / numberofColumns
        let heightDeductionPerItem = (screenHeight - heightDeduction) / numberofRows

        itemSize = CGSize.init(width: widthDeductionPerItem, height: heightDeductionPerItem)
        
        
    }
    

        // NECESSARY METHODS FOR CollectionView

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSlices.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "puzzleCell", for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = imageSlices[indexPath.item]
        
        return cell
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
          headerReusableView = (self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)) as!
            HeaderReusableView
            
            return headerReusableView
        } else {
            
            footerReusableView = (self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)) as!
            FooterReusableView
            
            return footerReusableView
        }
    }
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return spacing }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return spacing }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {return sectionInsets }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {return itemSize }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize { return referenceSize }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize { return referenceSize }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
   // Write a function to randomize the imageSlices array after it's initially populated in viewDidLoad().
    
    func randomizeImages (images: [UIImage]) -> [UIImage] {
        
       var randomizedImages: [UIImage] = []
        
        for image in imageSlices {
            randomizedImages.insert(image, at:Int(drand48()))
        }
      
        
        return randomizedImages
        
    }
    
    
}


