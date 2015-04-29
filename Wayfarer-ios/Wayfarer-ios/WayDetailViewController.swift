//
//  WayDetailViewController.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/4/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

class WayDetailViewController: UIViewController {
    
    var way: Way?

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tasksLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var savedImageButton: UIButton!
    @IBOutlet weak var callToActionView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dashedSeparatorView: UIView!
    @IBOutlet weak var letsGoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.showsVerticalScrollIndicator = false;
        
        self.titleLabel.text = self.way!.title.uppercaseString;
        self.subTitleLabel.text = self.way!.subTitle;
        self.descriptionLabel.text = (self.way!.descriptions.count > 0) ? self.way!.descriptions[0] : "";
        self.tasksLabel.text = (self.way!.tasks.count > 0) ? self.way!.tasks[0] : "";
        self.tipsLabel.text = (self.way!.tips.count > 0) ? self.way!.tips[0] : "";
        self.letsGoButton.layer.borderWidth = 2;
        self.letsGoButton.layer.borderColor = UIColor.whiteColor().CGColor;
        self.savedImageButton.setImage(
            self.way!.isSaved ? UIImage(named: "heart_selected") : UIImage(named: "heart"),
            forState: UIControlState.Normal)
        self.way?.fetchImage(is2x: true, isAsync: true, callback: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLetsGoPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("WayInProgressViewController") as! WayInProgressViewController;
        let presentingNavController = self.presentingViewController as! UINavigationController;
        vc.way = way;
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: {() -> Void in
            presentingNavController.pushViewController(vc, animated: true);
        });
    }
    
    @IBAction func onClosePressed() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func onSavedImageButtonPressed() {
        self.way!.isSaved = !(self.way!.isSaved)
        self.savedImageButton.setImage(
            self.way!.isSaved ? UIImage(named: "heart_selected") : UIImage(named: "heart"),
            forState: UIControlState.Normal)
        let qos = Int(QOS_CLASS_USER_INITIATED.value);
        dispatch_async(dispatch_get_global_queue(qos, 0)) {
            WayAPI.saveWayForUser(AppDelegate.userId, wayId: self.way!.id, isSaved: self.way!.isSaved)
        }
    }
    
}
