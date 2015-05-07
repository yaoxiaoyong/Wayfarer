//
//  WayInProgressViewController.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/19/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

class WayInProgressViewController: UIViewController {
    
    var way: Way?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var tasksContainerView: UIView!
    
    @IBOutlet weak var completedButton: UIButton!
    
    @IBOutlet weak var taskLabel1: UILabel!
    @IBOutlet weak var taskLabel2: UILabel!
    @IBOutlet weak var taskLabel3: UILabel!
    @IBOutlet weak var taskLabel4: UILabel!
    @IBOutlet weak var taskLabel5: UILabel!
    @IBOutlet weak var taskLabel6: UILabel!
    
    
    @IBOutlet weak var taskCompletionButton1: TaskItemButton!
    @IBOutlet weak var taskCompletionButton2: TaskItemButton!
    @IBOutlet weak var taskCompletionButton3: TaskItemButton!
    @IBOutlet weak var taskCompletionButton4: TaskItemButton!
    @IBOutlet weak var taskCompletionButton5: TaskItemButton!
    @IBOutlet weak var taskCompletionButton6: TaskItemButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = way?.title
        self.way?.fetchImage(is2x: true, isAsync: true, callback: self.setImage)
        setUIElements();
    }
    
    override func viewWillAppear(animated: Bool) {
        
        var backButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton;
        //backButton.frame = CGRectMake(0, 0, 13, 13);
        backButton.sizeToFit();
        backButton.setImage(UIImage(named: "back_arrow"), forState: UIControlState.Normal);
        backButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3 , bottom: 3, right: 3)
        backButton.addTarget(self, action: "handleBackButtonPress", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton);
    }
    
    func handleBackButtonPress() {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    private func setUIElements() {
        self.titleLabel.text = self.way?.title.uppercaseString;
        self.subtitleLabel.text = self.way?.subTitle;
        self.completedButton.layer.borderWidth = 2;
        self.completedButton.layer.borderColor = UIColor.whiteColor().CGColor;
        var count = self.way?.tasks.count;
        
        var taskLabels: [UILabel!] = [
            taskLabel1,
            taskLabel2,
            taskLabel3,
            taskLabel4,
            taskLabel5,
            taskLabel6
        ];
        
        var taskCompletionButtons: [TaskItemButton!] = [
            taskCompletionButton1,
            taskCompletionButton2,
            taskCompletionButton3,
            taskCompletionButton4,
            taskCompletionButton5,
            taskCompletionButton6
        ];
        
        while (count != taskLabels.count) {
            taskLabels.removeLast().removeFromSuperview();
            taskCompletionButtons.removeLast().removeFromSuperview();
        }
        
        for taskIndex in 0..<taskLabels.count {
            var task = taskLabels[taskIndex];
            task.text = self.way?.tasks[taskIndex]
        }

    }
    
    private func setImage(id: Int) -> Void {
        if (self.way?.id == id) {
            self.imageView.image = self.way?.image2x;
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func handleTaskButtonTouch(sender: TaskItemButton) {
        sender.isTaskCompleted = !sender.isTaskCompleted;
        
    }
    
    
    @IBAction func handleWayCompletionButtonTouch() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("WayFinished") as! WayFinishedViewController;
        vc.way = way;
        self.navigationController?.pushViewController(vc, animated: true);
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
