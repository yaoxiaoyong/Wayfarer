//
//  DataImporter.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 3/27/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import Foundation



class DataImporter {
    
    func importData(userUUID: Int) -> WaysContext? {
        var dataURL =  NSURL(string: Globals.apiRoot + "user/\(userUUID)/ways");
        let jsonData = NSData(contentsOfURL: dataURL!);
        var dataString = NSString(data: jsonData!, encoding: NSUTF8StringEncoding) as! String;
        let utfJsonData = dataString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false);
        
        var error : NSError?
        
        let parseResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(utfJsonData!, options: nil, error: &error);
        if ((parseResult) != nil) {
            let JSONArray =  parseResult! as! NSArray
            var ways: Array<Way> = [];
            
            for w in JSONArray  {
                var tmpWay = Way();
                tmpWay.setValuesForKeysWithDictionary(w as! [NSObject : AnyObject])
                ways.append(tmpWay);
            }
            var c: WaysContext = WaysContext(ways: ways);
            return c;
        } else {
            return nil;
        }
    }
}
