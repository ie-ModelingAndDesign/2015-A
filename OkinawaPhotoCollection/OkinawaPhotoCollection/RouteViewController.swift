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
import CoreLocation

class RouteViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
	
	let myLocationManager: CLLocationManager = CLLocationManager()
	
	var userLocation: CLLocationCoordinate2D!
	var destLocation: CLLocationCoordinate2D!
	
	var myMapView: MKMapView! = MKMapView()
	
	var latitude = CLLocationDegrees()
	var longitude = CLLocationDegrees()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		myLocationManager.delegate = self
//		myLocationManager.requestAlwaysAuthorization()
//		myLocationManager.startUpdatingLocation()
		
        let realm = try! Realm()
        let photo = realm.objects(Photo).filter("id == \(self.delegate.pictureID)").first!
		self.destLocation = CLLocationCoordinate2DMake(photo.latitude, photo.longitude)
		
        var place: String = ""
        if photo.place == 0 {
            place = "北部"
        } else if photo.place == 1 {
            place = "中部"
        } else if photo.place == 2 {
            place = "南部"
        }
		
		let destLocationAnnotation: MKPointAnnotation = MKPointAnnotation()
		destLocationAnnotation.coordinate = self.destLocation
		destLocationAnnotation.title = photo.name
		destLocationAnnotation.subtitle = place
		self.myMapView.addAnnotation(destLocationAnnotation)
		
		let span: MKCoordinateSpan = MKCoordinateSpanMake(1, 1)
		let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.destLocation.latitude, self.destLocation.longitude)
		let region: MKCoordinateRegion = MKCoordinateRegionMake(center, span)
		
		self.myMapView.setRegion(self.myMapView.regionThatFits(region), animated: true)
        
        // MapViewを生成.
        myMapView.frame = self.view.frame
		myMapView.delegate = self
        
        // 経度、緯度.
		let status = CLLocationManager.authorizationStatus()
		
		if status == CLAuthorizationStatus.NotDetermined {
			self.myLocationManager.requestAlwaysAuthorization()
		}
		
		myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
		myLocationManager.distanceFilter = 300
		
		self.myLocationManager.startUpdatingLocation()
		
//		let requestCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(requestLatitude, requestLongitude)
//		
//        // 中心点.
//		let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake((myLatitude + requestLatitude)/2, (myLongitude + requestLongitude)/2)
//		
//        // MapViewに中心点を設定.
//		myMapView.setCenterCoordinate(center, animated: true)
//		
//		
//        // 表示領域.
//        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
//        let myRegion: MKCoordinateRegion = MKCoordinateRegionMake(center, mySpan)
//        
//        // centerを指すアノテーションを生成.
//        let myPointAnnotation: MKPointAnnotation = MKPointAnnotation()
//        myPointAnnotation.title = "title"
//        myPointAnnotation.subtitle = "subtitle"
//        
//        
        // MapViewにregionを追加.
//        myMapView.region = myRegion
		
        // viewにMapViewを追加.
        self.view.addSubview(myMapView)
//
//
        // ピンを生成.
//        let myPin: MKPointAnnotation = MKPointAnnotation()
//        myPin.coordinate = center         // 座標を設定.
//        myPin.title = photo.name           // タイトルを設定.
//        myPin.subtitle = place         // サブタイトルを設定.
//        myMapView.addAnnotation(myPin)   // MapViewにピンを追加.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		userLocation = CLLocationCoordinate2DMake(manager.location!.coordinate.latitude, manager.location!.coordinate.longitude)
		
		var userLocationAnnotation: MKPointAnnotation = MKPointAnnotation()
		userLocationAnnotation.coordinate = userLocation
		userLocationAnnotation.title = "現在地"
		myMapView.addAnnotation(userLocationAnnotation)
		self.getRoute()
	}
	
	func getRoute() {
		let fromPlacemark = MKPlacemark(coordinate: userLocation, addressDictionary: nil)
		let toPlacemark = MKPlacemark(coordinate: destLocation, addressDictionary: nil)
		
		let fromItem = MKMapItem(placemark: fromPlacemark)
		let toItem = MKMapItem(placemark: toPlacemark)
		
		let request = MKDirectionsRequest()
		
		request.source = fromItem
		request.destination = toItem
		request.requestsAlternateRoutes = false
		request.transportType = MKDirectionsTransportType.Any
		
		let directions = MKDirections(request: request)
		directions.calculateDirectionsWithCompletionHandler({ (response: MKDirectionsResponse?, error: NSError?) -> Void in
			print(response!.routes.count)
			if (error != nil || response!.routes.isEmpty) {
				return
			}
			let route: MKRoute = response!.routes[0] as MKRoute
			self.myMapView.addOverlay(route.polyline)
			self.showUserAndDestinationOnMap()
		})
	}
	
	func showUserAndDestinationOnMap() {
		
		print("CallMeMaybe")
		let maxLat: Double = fmax(userLocation.latitude, destLocation.latitude)
		let maxLon: Double = fmax(userLocation.longitude, destLocation.longitude)
		let minLat: Double = fmin(userLocation.latitude, destLocation.latitude)
		let minLon: Double = fmin(userLocation.longitude, destLocation.longitude)
		
		let mapMargin: Double = 1.5
		let leastCoordSpan: Double = 0.005
		let spanX: Double = fmax(leastCoordSpan, fabs(maxLat - minLat) * mapMargin)
		let spanY: Double = fmax(leastCoordSpan, fabs(maxLon - minLon) * mapMargin)
		
		let span: MKCoordinateSpan = MKCoordinateSpanMake(spanX, spanY)
		
		let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2)
		let region: MKCoordinateRegion = MKCoordinateRegionMake(center, span)
		
		self.myMapView.setRegion(self.myMapView.regionThatFits(region), animated: true)
	}
	
	func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
		if overlay is MKPolyline {
			let polylineRenderer = MKPolylineRenderer(overlay: overlay)
			polylineRenderer.strokeColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 1.0, alpha: 0.5)
			polylineRenderer.lineWidth = 5
			return polylineRenderer
		}
		return MKPolylineRenderer()
	}
	
//	func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
//		latitude = newLocation.coordinate.latitude
//		longitude = newLocation.coordinate.longitude
//		
//		myLocationManager.stopUpdatingLocation()
//	}
	
	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		print("Error")
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
