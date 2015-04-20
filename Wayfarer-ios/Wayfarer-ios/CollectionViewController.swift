//
//  CollectionViewController.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/3/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

let reuseIdentifier = "ExperimentCell"

class CollectionViewController: UICollectionViewController {
    
    let delegate = UIApplication.sharedApplication().delegate as AppDelegate;
    var context: WaysContext?

    override func viewDidLoad() {
        self.context = delegate.Context;
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal;
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        
        layout.minimumLineSpacing = CGFloat(2);
        layout.minimumInteritemSpacing = CGFloat(1);
        
        collectionView!.setCollectionViewLayout(layout, animated: true);
        collectionView!.backgroundColor = UIColor.whiteColor();
        
        
        var navBarHeight: CGFloat = 0;
        if (self.navigationController != nil) {
            navBarHeight = self.navigationController!.navigationBar.frame.height;
            navBarHeight += UIApplication.sharedApplication().statusBarFrame.size.height;
        }
        
        
        
        var size = CGSize(
            width: collectionView!.frame.width / 2,
            height: (collectionView!.frame.height - navBarHeight) / 3
        );
        
        layout.itemSize = size;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, minimumLineSpacingForSectionAtIndex section: Int) ->Int {
        return 0;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        let count = context!.getCount();
        return count + count % 6;
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as CollectionViewCell
        var wayModel = getWayByRow(indexPath.row);
        cell.backgroundImageView = nil;
        cell.backgroundView = nil;
        cell.setWay(wayModel);
        if (wayModel != nil) {
            wayModel!.fetchImage(is2x: false, isAsync: true, callback: cell.setImage)
        }
        if (Globals.prefetchNextPage) {
            prefetchNextPageImages(indexPath.row);
        }
        
        return cell
    }
    
    /*
     Assumptions:
        We really only interested in fetch the next page with page being defined in interval of six.
        So to optimize, we are only going to fetch on the first index of the current page for the next page, so 1, 7, 13
    */
    
    private func prefetchNextPageImages(row: Int) {
        if (row % 6 == 5) {
            for index in 1..<7 {
                if let way = getWayByRow(row + index) {
                    way.fetchImage(is2x: false, isAsync: true, callback: {(id: Int) -> Void in print("GOT HERE!!! \(row + index)")});
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var navBarHeight: CGFloat = 0;
        if (self.navigationController != nil) {
            navBarHeight = self.navigationController!.navigationBar.frame.height;
            navBarHeight += UIApplication.sharedApplication().statusBarFrame.size.height;
        }
        
        var size = CGSize(
            width: collectionView.frame.width / 2 - 2,
            height: floor((collectionView.frame.height - navBarHeight) / 3 - 0.5)
        );
        println("collection view height: \(collectionView.frame.size.height)");
        println("collection view bounds: \(collectionView.bounds.height)");
        println("main screen app size: \(UIScreen.mainScreen().applicationFrame.size)")
        println("status bar height: \(navBarHeight)")
        println("calculated size: \(size)");
        return size;
    }
    
    private func getWayByRow(row: Int) -> Way? {
        var calculatedId = 0;
        switch (row % 6) {
        case 0:
            calculatedId = row + 1;
            break;
        case 1:
            calculatedId = row + 2;
            break;
        case 2:
            calculatedId = row + 3;
            break;
        case 3:
            calculatedId = row - 1;
            break;
        case 4:
            calculatedId = row;
            break;
        case 5:
            calculatedId = row + 1;
            break;
        default:
            break;
        }
        
        if (calculatedId > context!.getCount()) {
            return nil;
        }
        return context!.getWayById(calculatedId);
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row <= self.context!.getCount()) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("WayDetailViewController") as WayDetailViewController;
            vc.way = getWayByRow(indexPath.row);
            vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
            self.providesPresentationContextTransitionStyle = true;
            self.presentViewController(vc, animated: true, completion: nil);
        }
    }
    
//    func showBlockAtBottom() {
//        let wayDetailVc = self.presentedViewController! as WayDetailViewController;
//        let frame = wayDetailVc.callToActionView.frame;
////        let interpolatedFrame = CGRect(
////            origin: CGPoint(
////                x: 0,
////                y: self.collectionView!.frame.size.height - frame.size.height),
////            size: frame.size
////        );
//        
//        let interpolatedFrame = CGRect(
//            origin: CGPoint(
//                x: 0,
//                y: self.collectionView!.frame.size.height - frame.size.height - 64),
//            size: frame.size
//        );
//        
//        print (self.collectionView!.frame.size.height - 100)
////        let interpolatedFrame = self.collectionView!.convertPoint(frame.origin);
//        let blockView = UIView(frame: interpolatedFrame);
//        blockView.backgroundColor = UIColor(red: 41 / 256, green: 49 / 256, blue: 65 / 256, alpha: 1);
//        self.collectionView!.addSubview(blockView);
//    }
    
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
