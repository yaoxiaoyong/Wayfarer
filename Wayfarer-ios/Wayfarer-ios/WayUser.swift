//
//  WayUser.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/27/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import Foundation

class WayUser: NSObject {
    var email: String?
    var firstName: String?
    var lastName: String?
    var id: Int?
    var savedWays: Array<Way> = []
}