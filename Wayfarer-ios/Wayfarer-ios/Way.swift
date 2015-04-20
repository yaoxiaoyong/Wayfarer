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
    var image2x: UIImage!
    var isSaved: Bool = false;
    var isSaved2x: Bool = false;
    
    // We use a prefetch method and we do not want to g
    
    private var isFetching = false;
    private var isFetching2x = false;
    private var callbackQueue: Array<(id: Int) -> Void> = [];
    private var callbackQueue2x: Array<(id: Int) -> Void> = [];
    
    var coverImage2x: String {
        get {
            if (coverImage == "") {
                return "";
            }
            let character: Character = "."
            if let idx = find(coverImage, character) {
                return coverImage.substringToIndex(idx) + "@2x" + coverImage.substringFromIndex(idx);
            } else {
                return "";
            }
        }
    };
    
    func fetchImage(is2x: Bool = false, isAsync: Bool = true, callback: (id: Int) -> Void) -> Void {
        if (isAsync) {
            if (is2x) {
                callbackQueue2x.append(callback);
            } else {
                callbackQueue.append(callback);
            }
        }
        if ((is2x && self.image2x == nil) || (!is2x && self.image == nil)) {
            if ((is2x && !isFetching2x) || (!is2x && !isFetching)) {
                let urlString = Globals.staticResourcesRoot + ((is2x) ? coverImage2x : self.coverImage);
                let url = NSURL(string: urlString);
                if (isAsync) {
                    let qos = Int(QOS_CLASS_USER_INITIATED.value);
                    dispatch_async(dispatch_get_global_queue(qos, 0)) {
                        self.imageGetterWorkerFunction(url, is2x: is2x, isAsync: true, callback: callback);
                        self.callCallbacks(is2x, id: self.id);
                    }
                } else {
                    self.imageGetterWorkerFunction(url, is2x: is2x, isAsync: false, callback: callback);
                }
            }
        } else {
            if (isAsync) {
                callCallbacks(is2x, id: id);
            }
        }
    }
    
    private func callCallbacks(is2x: Bool, id: Int) {
        if (is2x) {
            for cb in callbackQueue2x {
                cb(id: id);
            }
            callbackQueue2x = [];
        } else {
            for cb in callbackQueue {
                cb(id: id);
            }
            callbackQueue = [];
        }
    }
    
    private func imageGetterWorkerFunction (url: NSURL?, is2x: Bool, isAsync: Bool, callback: (id: Int) -> Void) -> Void {
        let imageData = NSData(contentsOfURL: url!);
        if (isAsync) {
            dispatch_async(dispatch_get_main_queue()) {
                self.imageGetterInnerWorkerFunction(imageData, is2x: is2x);
                callback(id: self.id);
            }
        } else {
            self.imageGetterInnerWorkerFunction(imageData, is2x: is2x);
        }
    }
    
    private func imageGetterInnerWorkerFunction (imageData: NSData?, is2x: Bool) {
        if imageData != nil {
            if (is2x) {
                self.image2x = UIImage(data: imageData!);
            } else {
                self.image = UIImage(data: imageData!);
            }
        } else {
            if (is2x) {
                self.image2x = nil;
            } else {
                self.image = nil;
            }
        }
    }
}
