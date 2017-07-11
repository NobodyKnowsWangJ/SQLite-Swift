//
//  Team.swift
//  RealmDatabase
//
//  Created by 王 on 2017/07/10.
//  Copyright © 2017年 WangJun. All rights reserved.
//

import Foundation
import RealmSwift

class Team: Object {
    dynamic var city = ""
    dynamic var nickname:String?
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
