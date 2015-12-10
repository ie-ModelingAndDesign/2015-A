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
        
        
        
        // Delegateを設定.
        myMapView.delegate = self
        
        
        
        
        // 経度、緯度.
        let myLatitude: CLLocationDegrees = CLLocationDegrees(photo.latitude)
        let myLongitude: CLLocationDegrees = CLLocationDegrees(photo.longitude)
        
        
        
        // 目的地の緯度、経度を設定.
        let requestLatitude: CLLocationDegrees = 26.247589
        let requestLongitude: CLLocationDegrees = 127.765279
        
        
        
        // 目的地の座標を指定.
        let requestCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(requestLatitude, requestLongitude)
        let fromCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)

        
        
        
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
        
        
        
        // PlaceMarkを生成して出発点、目的地の座標をセット.
        let fromPlace: MKPlacemark = MKPlacemark(coordinate: fromCoordinate, addressDictionary: nil)
        let toPlace: MKPlacemark = MKPlacemark(coordinate: requestCoordinate, addressDictionary: nil)
        
        
        // Itemを生成してPlaceMarkをセット.
        let fromItem: MKMapItem = MKMapItem(placemark: fromPlace)
        let toItem: MKMapItem = MKMapItem(placemark: toPlace)
        
        // MKDirectionsRequestを生成.
        let myRequest: MKDirectionsRequest = MKDirectionsRequest()
        
        // 出発地のItemをセット.
        myRequest.source = fromItem
        
        // 目的地のItemをセット.
        myRequest.destination = toItem
        
        // 複数経路の検索を有効.
        myRequest.requestsAlternateRoutes = true
        
        // 移動手段を車に設定.
        myRequest.transportType = MKDirectionsTransportType.Automobile

        
        // MKDirectionsを生成してRequestをセット.
        let myDirections: MKDirections = MKDirections(request: myRequest)
        
        // 経路探索.
        myDirections.calculateDirectionsWithCompletionHandler {
            response, error in
            
            guard let response = response else {
                //handle the error here
                return
            }
            
            let route: MKRoute = response.routes[0] as MKRoute
            print("目的地まで \(route.distance)km")
            print("所要時間 \(Int(route.expectedTravelTime/60))分")
            
            // mapViewにルートを描画.
            myMapView.addOverlay(route.polyline)
        }

        
        
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
        let toPin: MKPointAnnotation = MKPointAnnotation()
        
        // 座標をセット.
        myPin.coordinate = center
        toPin.coordinate = requestCoordinate
        
        // titleをセット.
        myPin.title = photo.name
        toPin.title = "琉球大学"
        
        
        //subtitleをセット
        myPin.subtitle = place
        toPin.subtitle = "中部"
        
        // mapViewに追加.
        myMapView.addAnnotation(myPin)
        myMapView.addAnnotation(toPin)

        
    }
    
    
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        let route: MKPolyline = overlay as! MKPolyline
        let routeRenderer: MKPolylineRenderer = MKPolylineRenderer(polyline: route)
        
        // ルートの線の太さ.
        routeRenderer.lineWidth = 3.0
        
        // ルートの線の色.
        routeRenderer.strokeColor = UIColor.redColor()
        return routeRenderer
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
