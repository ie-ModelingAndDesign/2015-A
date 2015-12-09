//
//  RealmObjects.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/09.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import RealmSwift

class Photo: Object {
    dynamic var id: Int = 0
    dynamic var latiitude: Float = 0.0
    dynamic var longitude: Float = 0.0
    dynamic var photoLocate: String = ""
    dynamic var photoURL: String = ""
    
    override class func primaryKey() -> String {
        return "id"
    }
}
