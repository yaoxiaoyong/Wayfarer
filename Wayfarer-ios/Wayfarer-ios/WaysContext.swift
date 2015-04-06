//
//  WaysContext.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 3/27/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import Foundation

class WaysContext {
    
    var Ways: Array<Way>;
    
    init(ways: Array<Way>) {
        self.Ways = ways;
    }
    
    func getWayById(id: Int) -> Way? {
        if (id >= 1 && id <= self.Ways.count) {
            return self.Ways[id - 1];
        } else {
            return nil;
        }
    }
    
    func getCount () -> Int {
        return self.Ways.count;
    }
    
}
