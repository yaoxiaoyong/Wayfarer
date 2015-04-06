//
//  Way.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 3/27/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import Foundation
import UIKit

class Way: NSObject {
    var id: Int = 0;
    var title: String = "";
    var subTitle: String = "";
    var descriptions: Array<String> = [];
    var tasks: Array<String> = [];
    var tips: Array<String> = [];
    var items: Array<String> = [];
    var transportation: Array<String> = [];
    var coverImage: String = "";
    var image: UIImage!
    
    func fetchImage(callback: (id: Int) -> Void) -> Void {
        if (self.image == nil) {
            let urlString = "http://localhost:9000/" + self.coverImage;
            let url = NSURL(string: urlString);
            let qos = Int(QOS_CLASS_USER_INITIATED.value);
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: url!);
                dispatch_async(dispatch_get_main_queue()) {
                    if imageData != nil {
                        self.image = UIImage(data: imageData!);
                        print("fetched data for " + urlString + "\n\n");
                        callback(id: self.id);
                    } else {
                        print("failed to get data for " + urlString);
                        self.image = nil;
                        callback(id: self.id);
                    }
                }
            }

        } else {
            callback(id: self.id);
        }
    }
}
