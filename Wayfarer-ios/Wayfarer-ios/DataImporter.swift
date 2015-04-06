//
//  DataImporter.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 3/27/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import Foundation



class DataImporter {
    
    func importData() -> WaysContext {
        var dataURL =  NSURL(string: "http://localhost:9000/data");
        let jsonData = NSData(contentsOfURL: dataURL!);
        var dataString = NSString(data: jsonData!, encoding: NSUTF8StringEncoding) as String;
        let utfJsonData = dataString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false);
        
        var error : NSError?
        
        let JSONArray: Array = NSJSONSerialization.JSONObjectWithData(utfJsonData!, options: nil, error: &error) as NSArray;
        var ways: Array<Way> = [];
        for w in JSONArray{
            var tmpWay = Way();
            tmpWay.setValuesForKeysWithDictionary(w as Dictionary);
            ways.append(tmpWay);
        }
        var c: WaysContext = WaysContext(ways: ways);
        return c;
    }
}
