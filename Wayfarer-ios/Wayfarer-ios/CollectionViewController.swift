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
    
    var context: WaysContext?
    let showFilterBar = true;
    var filterBarHeight: CGFloat!;
    var showFiltersButton: UIButton!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.context = AppDelegate.Context;
        
        filterBarHeight = showFilterBar ? 20 : 0;
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal;
        layout.sectionInset = UIEdgeInsets(top: filterBarHeight, left: 1, bottom: 0, right: 0);
        
        layout.minimumLineSpacing = CGFloat(2);
        layout.minimumInteritemSpacing = CGFloat(1);
        
        collectionView!.setCollectionViewLayout(layout, animated: true);
        collectionView!.backgroundColor = UIColor.whiteColor();
        
        var size = CGSize(
            width: collectionView!.frame.width / 2,
            height: (collectionView!.frame.height) / 3
        );
        
        layout.itemSize = size;

        if (self.showFilterBar) {
            addFilterBar();
        }
    }
    
    func addFilterBar() {
        var navBarHeight: CGFloat = 0;
        if (self.navigationController != nil) {
            navBarHeight = self.navigationController!.navigationBar.frame.height;
            navBarHeight += UIApplication.sharedApplication().statusBarFrame.size.height;
        }

        var subv = UIView(frame: CGRectMake(
            0,
            0,
            self.collectionView!.frame.size.width,
            self.filterBarHeight)
        );

        subv.backgroundColor = UIColor.whiteColor()
        
        collectionView?.superview?.addSubview(subv);
        showFiltersButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton;
        showFiltersButton.addTarget(self, action: "handleShowFilters", forControlEvents: UIControlEvents.TouchUpInside)
        showFiltersButton.frame = subv.bounds;
        showFiltersButton.titleLabel?.font = UIFont(name: "Dual", size: 15)
        showFiltersButton.setTitleColor(UIHelper.greenColor, forState: UIControlState.Normal)
        showFiltersButton.titleEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 5, right: 0);
        showFiltersButton.setTitle("Show Filters", forState: UIControlState.Normal);
        subv.addSubview(showFiltersButton);
    }
    
    func handleShowFilters () {
        showFilterSelectionScreen();
    }
    
    func showFilterSelectionScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("FiltersViewController") as! FiltersViewController;
//        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
        self.addChildViewController(vc);
        vc.view.frame = collectionView!.frame
        collectionView?.superview?.addSubview(vc.view);
        vc.didMoveToParentViewController(self);
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
        return 54;//count + count % 6;
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        var wayModel = getWayByRow(indexPath.row);
        cell.backgroundImageView = nil;
        cell.backgroundView = nil;
        cell.setWayModel(wayModel);
        if (wayModel != nil) {
            wayModel!.fetchImage(is2x: false, isAsync: true, callback: cell.setImage)
        } else {
            cell.backgroundColor = UIColor(red: 41 / 256, green: 49 / 256, blue: 65 / 256, alpha: 1);
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
                    way.fetchImage(is2x: false, isAsync: true, callback: nil);
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
            height: floor(((collectionView.frame.height - filterBarHeight) / 3) - 1)
        );
            
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
            let vc = storyboard.instantiateViewControllerWithIdentifier("WayDetailViewController") as! WayDetailViewController;
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
