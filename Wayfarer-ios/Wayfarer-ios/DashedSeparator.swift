//
//  DashedSeparator.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/5/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

class DashedSeparator: UIView {
    
    var verticalSections: Int = 150;
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.backgroundColor = UIColor.clearColor();
    }
    

    override func drawRect(rect: CGRect) {
//        self.backgroundColor = UIColor.clearColor();
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context,rect)
        CGContextSetLineWidth(context, 2.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let greenComponents: [CGFloat] = [55.0 / 256.0, 209.0 / 256.0, 139.0 / 256.0, 1.0]
        let clearComponents: [CGFloat] = [1, 1, 1, 0.0]
        let greenColor = CGColorCreate(colorSpace, greenComponents)
        let clearColor = CGColorCreate(colorSpace, clearComponents)
        CGContextSetStrokeColorWithColor(context, greenColor);
        
        var lastX: CGFloat = 0;
        
        let interval = Float(self.frame.width) / Float(self.verticalSections);
        
        for index in 1...self.verticalSections {
            CGContextMoveToPoint(context, lastX, 0)
            let x: CGFloat = CGFloat(Double(Double(interval) * Double(index)));
            let y: CGFloat = 0.0;
            if (index % 2 == 1 ) {
                CGContextSetStrokeColorWithColor(context, greenColor);

            } else {
                CGContextSetStrokeColorWithColor(context, clearColor);
            }
            
            CGContextAddLineToPoint(context, x, 0)
            CGContextStrokePath(context)
            

            lastX = x;
        }
        //CGContextAddLineToPoint(context, 5, 0)
        
        
        
//        let frameWidth = Float(self.frame.width)
//        
//        let intervalLength: Float = Float( frameWidth/ Float(verticalSections));
//        var currentXValue = 0;
//        
//        for index in 0...verticalSections {
//            if (index % 2 == 0) {
//                
//            }
//        }
    }

}
