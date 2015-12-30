//
//  CommentRealm.swift
//  textfield
//
//  Created by Yutaro Miyazato on 12/23/15.
//  Copyright © 2015 hoge. All rights reserved.
//

import RealmSwift

class Comment: Object {
    dynamic var id: Int = 0
    dynamic var Comment: String = ""
    dynamic var Username: String = ""
    
    override class func primaryKey() -> String {
        return "id"
    }
}
