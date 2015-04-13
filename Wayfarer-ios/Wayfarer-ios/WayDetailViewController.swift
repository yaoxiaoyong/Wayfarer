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
    @IBOutlet weak var savedImageView: UIImageView!
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
        self.savedImageView.image = self.way!.isSaved ? UIImage(named: "heart_selected") : UIImage(named: "heart");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLetsGoPressed() {
    }
    
    @IBAction func onClosePressed() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
    }
    
}
