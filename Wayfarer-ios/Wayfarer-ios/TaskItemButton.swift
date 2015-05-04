//
//  TaskItemButton.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 5/3/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

class TaskItemButton: UIButton {
    
    var isTaskCompleted: Bool = false {
        didSet { setNeedsDisplay()}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.backgroundColor = UIColor.clearColor()
    }

    override func drawRect(rect: CGRect) {
        drawCirlce()
    }
    
    private func drawCirlce() {
        let width = self.bounds.width;
        let height = self.bounds.height;
        let radius = CGFloat(4)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2 ), radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        circlePath.lineWidth = CGFloat(1)
        let greenComponents: [CGFloat] = [55.0 / 256.0, 209.0 / 256.0, 139.0 / 256.0, 1.0]
        let greenColor = UIColor(red: greenComponents[0], green: greenComponents[1], blue: greenComponents[2], alpha: greenComponents[3]);
        greenColor.set();
        circlePath.stroke();
        if (isTaskCompleted) {
            circlePath.fill()
        }
    }
    
    

}
