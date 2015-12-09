//
//  InportDatas.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/10.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class ImportDatas {
    
    init() {
        print(Realm.Configuration.defaultConfiguration.path!)
    }
    
    func run() -> String {
        let realm = try! Realm()
        let activityPath = NSBundle.mainBundle().pathForResource("Activity", ofType: "json")
        let foodPath = NSBundle.mainBundle().pathForResource("Food", ofType: "json")
        
        var i = 0
        if let actData = NSData(contentsOfFile: activityPath!) {
            let json = JSON.init(data: actData)
            for j in json {
                let insData: Photo = Photo()
                i++
                insData.id = i
                insData.latitude = j.1["latitude"].asFloat!
                insData.longitude = j.1["longitude"].asFloat!
                let photoName: String = j.1["photoName"].asString! + ".jpg"
                insData.photoName = photoName
                
//                let image: NSData? = NSData(contentsOfFile: j.1["photoName"].asString! + ".jpg")
                let path: NSFileHandle = NSFileHandle(forReadingAtPath: NSBundle.mainBundle().pathForResource(j.1["photoName"].asString!, ofType: "jpg")!)!
                let image: NSData? = path.readDataToEndOfFile()
                let documents: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/" + photoName
                NSFileManager.defaultManager().createFileAtPath(documents, contents: image, attributes: nil)
//                try! NSFileManager.defaultManager().copyItemAtPath(NSBundle.mainBundle().pathForResource(j.1["photoName"].asString!, ofType: "jpg")!, toPath: documents + j.1["photoName"].asString! + ".jpg")
                
                
                insData.url = j.1["siteURL"].asString!
                insData.place = j.1["place"].asInt!
                try! realm.write({
                    realm.add(insData)
                })
            }
        }
        
        if let foodData = NSData(contentsOfFile: foodPath!) {
            let json = JSON.init(data: foodData)
            for j in json {
                let insData: Photo = Photo()
                i++
                insData.id = i
                insData.latitude = j.1["latitude"].asFloat!
                insData.longitude = j.1["longitude"].asFloat!
                let photoName: String = j.1["photoName"].asString! + ".jpg"
                insData.photoName = photoName
                
//                let image: NSData? = NSData(contentsOfFile: j.1["photoName"].asString! + ".jpg")
                let path: NSFileHandle = NSFileHandle(forReadingAtPath: NSBundle.mainBundle().pathForResource(j.1["photoName"].asString!, ofType: "jpg")!)!
                let image: NSData? = path.readDataToEndOfFile()
                let documents: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/" + photoName
                NSFileManager.defaultManager().createFileAtPath(documents, contents: image, attributes: nil)
                insData.url = j.1["siteURL"].asString!
                insData.place = j.1["place"].asInt!
                try! realm.write({
                    realm.add(insData)
                })
            }
        }
//        try! realm.writeCopyToPath("/Users/aokabin/Desktop/photoData.realm")
        return "Copyed!"
    }
    
}