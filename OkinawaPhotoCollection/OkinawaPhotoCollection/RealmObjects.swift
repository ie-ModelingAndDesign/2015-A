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
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var photoName: String = ""
    dynamic var url: String = ""
    dynamic var place: Int = 0
    dynamic var name: String = ""
    
    override class func primaryKey() -> String {
        return "id"
    }
}
