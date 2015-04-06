//
//  CollectionView.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/3/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0);
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0);
    }
    
    func collectionView(collectionView: UICollectionView, insetForSectionAtIndex
        section: Int) ->Int {
            return 0;
    }
    
    func collectionView(collectionView: UICollectionView, minimumInteritemSpacingForSectionAtIndex section: Int) ->Int {
        return 0;
    }
    
    func collectionView(collectionView: UICollectionView, minimumLineSpacingForSectionAtIndex section: Int) ->Int {
        return 0;
    }
    
    func collectionView(collectionView: UICollectionView, sizeF section: Int) ->Int {
        return 0;
    }

}
