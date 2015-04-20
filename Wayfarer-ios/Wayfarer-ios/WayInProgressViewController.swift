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

    @IBOutlet weak var callToActionView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = way?.title
        self.way?.fetchImage(is2x: true, isAsync: true, callback: self.setImage)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
