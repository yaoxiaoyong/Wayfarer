//
//  Globals.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/12/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import Foundation

struct Globals {
    
    enum ENVIRONMENT {
        case local
        case prod
    };
    
    static let useCDN = false;
    static let environment = ENVIRONMENT.local;
    static let prefetchThumbnailsOnAppLoad = false;
    static let prefetchNextPage = true;
    
    static let apiRoot: String = (environment == ENVIRONMENT.prod) ? "https://wayfarer-backend.herokuapp.com/" : "http://localhost:9000/";
    static let staticResourcesRoot: String = (environment == ENVIRONMENT.prod && useCDN) ? "https://d314oora7wgipi.cloudfront.net/" : apiRoot;
}