//
//  WayFinishedViewController.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 5/3/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

class WayFinishedViewController: UIViewController {
    
    var way: Way!

    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImage.image = self.way.image2x;
        self.title = way.title;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        var backButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton;
        //backButton.frame = CGRectMake(0, 0, 13, 13);
        backButton.sizeToFit();
        backButton.setImage(UIImage(named: "back_arrow"), forState: UIControlState.Normal);
        backButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3 , bottom: 3, right: 3)
        backButton.addTarget(self, action: "handleBackButtonPress", forControlEvents: UIControlEvents.TouchUpInside)
        //self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton);
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton);
    }
    
    func handleBackButtonPress() {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func handleClosePressed() {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
