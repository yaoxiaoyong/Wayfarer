//
//  HttpUtil.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/27/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import Foundation

class HttpUtil {
    
    enum HTTP_METHOD {
        case GET
        case POST
        case PUT
    }
    
    static func PUT(urlString: String, body: String? = nil) -> NSData? {
        return request(.PUT, urlString: urlString, body: body)
    }
    
    static func POST(urlString: String, body: String? = nil) -> NSData? {
        return request(.POST, urlString: urlString, body: body)
    }
    
    static func GET(urlString: String, body: String? = nil) -> NSData? {
        return request(.GET, urlString: urlString, body: body)
        
    }
    
    private static func request(method: HTTP_METHOD, urlString: String, body: String? = nil) -> NSData? {
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        
        switch (method) {
        case .GET:
            request.HTTPMethod = "GET"
            break;
        case .POST:
            request.HTTPMethod = "POST"
            break;
        case .PUT:
            request.HTTPMethod = "PUT"
            break
            
        }
        
        var response = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var error = NSErrorPointer()
        return NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error);
    }
    

}
