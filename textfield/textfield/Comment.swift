//
//  Comment.swift
//  textfield
//
//  Created by Yutaro Miyazato on 12/23/15.
//  Copyright © 2015 hoge. All rights reserved.
//

import RealmSwift


class Comment :Object{
    dynamic var comment: String = ""
    dynamic var id: Int = 0
    
    
    override static func primaryKey() -> String? {
        return "id"
    }

}