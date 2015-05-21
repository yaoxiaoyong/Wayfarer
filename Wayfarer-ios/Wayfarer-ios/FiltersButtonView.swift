//
//  FiltersButtonView.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 5/17/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

class FiltersButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.backgroundColor = UIColor.clearColor()
    }


    override func drawRect(rect: CGRect) {
        drawCirlcle();
    }
    
    func drawCirlcle() {
        let width = self.bounds.width;
        let height = self.bounds.height;
        let radius = self.bounds.width / 2;
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2 ), radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)

        UIColor.whiteColor().setFill();
        circlePath.fill()
    }
}
