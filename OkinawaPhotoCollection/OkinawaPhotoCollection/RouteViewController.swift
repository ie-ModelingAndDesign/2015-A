//
//  RouteViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/10.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class RouteViewController: UIViewController, MKMapViewDelegate {
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        let photo = realm.objects(Photo).filter("id == \(self.delegate.pictureID)").first!
        
        // MapViewを生成.
        let myMapView: MKMapView = MKMapView()
        myMapView.frame = self.view.frame
        
        // 経度、緯度.
        let myLatitude: CLLocationDegrees = CLLocationDegrees(photo.latitude)
        let myLongitude: CLLocationDegrees = CLLocationDegrees(photo.longitude)
        
        // 中心点.
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
        
        // MapViewに中心点を設定.
        myMapView.setCenterCoordinate(center, animated: true)
        
        // 表示領域.
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMake(center, mySpan)
        
        // centerを指すアノテーションを生成.
        let myPointAnnotation: MKPointAnnotation = MKPointAnnotation()
        myPointAnnotation.title = "title"
        myPointAnnotation.subtitle = "subtitle"
        
        
        // MapViewにregionを追加.
        myMapView.region = myRegion
        
        // viewにMapViewを追加.
        self.view.addSubview(myMapView)
        
        var place: String = ""
        if photo.place == 0 {
            place = "北部"
        } else if photo.place == 1 {
            place = "中部"
        } else if photo.place == 2 {
            place = "南部"
        }
        
        // ピンを生成.
        let myPin: MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate = center         // 座標を設定.
        myPin.title = photo.name           // タイトルを設定.
        myPin.subtitle = place         // サブタイトルを設定.
        myMapView.addAnnotation(myPin)   // MapViewにピンを追加.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
