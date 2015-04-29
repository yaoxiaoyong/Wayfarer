//
//  WayAPI.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/27/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import Foundation


class WayAPI: NSObject {
    
    private static func getNewUserRoute() -> String {
        return "\(Globals.apiRoot)user";
    }
    
    private static func getUpdateSavedWayForUserRoute(userId: Int, wayId: Int, isSaved: Bool) -> String {
        var route = "\(Globals.apiRoot)user/\(userId)/ways/\(wayId)/";
        route += (isSaved) ? "save" : "unsave";
        return route;
    }
    
    
    private static func parseJSONData(data: NSData?) -> AnyObject? {
        if (data != nil) {
            var dataString = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String;
            let utfJsonData = dataString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false);
            var error2 : NSError?
        
            return NSJSONSerialization.JSONObjectWithData(utfJsonData!, options: nil, error: &error2);
        } else {
            return nil;
        }
    }
    
    static func saveWayForUser(userId: Int, wayId: Int, isSaved: Bool) {
        HttpUtil.POST(WayAPI.getUpdateSavedWayForUserRoute(userId, wayId: wayId, isSaved: isSaved));
    }
    

    static func createNewUser() -> WayUser? {
        var data = HttpUtil.PUT(getNewUserRoute());
        var parsedData: AnyObject? = parseJSONData(data);
        
        if (parsedData != nil) {
            var tmpWayUser: WayUser?
            let JSONDict =  parsedData! as! NSDictionary
            tmpWayUser = WayUser()
            tmpWayUser!.id = JSONDict["id"] as? Int;
            return tmpWayUser;
        } else {
            return nil;
        }

    }
}