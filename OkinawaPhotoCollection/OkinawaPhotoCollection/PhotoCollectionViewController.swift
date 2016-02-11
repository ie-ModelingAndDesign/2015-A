//
//  PhotoViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/09.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class PhotoCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate, UICollectionViewDelegateFlowLayout {
    var myCollectionView: UICollectionView!
    var photosArr: [Photo] = []
    
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // 現在地の位置情報の取得にはCLLocationManagerを使用
    let lm = CLLocationManager()
    // 取得した緯度を保持するインスタンス
    let latitude = CLLocationDegrees()
    // 取得した経度を保持するインスタンス
    let longitude = CLLocationDegrees()
    
    /* 位置情報取得成功時に実行される関数 */

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let btn = UIButton(frame: CGRectMake(self.view.bounds.size.width / 2 - 100, self.view.bounds.size.height / 2 - 20, 200, 40))
//        btn.backgroundColor = UIColor.blueColor()
//        btn.titleLabel?.text = "Stop"
//        btn.titleLabel?.textColor = UIColor.whiteColor()
//        btn.addTarget(self, action:"stop", forControlEvents: .TouchDown)
//        self.view.addSubview(btn)
        // CLLocationManagerをDelegateに指定
        lm.delegate = self
        
        // 位置情報取得の許可を求めるメッセージの表示．必須．
        lm.requestAlwaysAuthorization()
        // 位置情報の精度を指定．任意，
        // lm.desiredAccuracy = kCLLocationAccuracyBest
        // 位置情報取得間隔を指定．指定した値（メートル）移動したら位置情報を更新する．任意．
        // lm.distanceFilter = 1000
        lm.startUpdatingLocation()
        
        // GPSの使用を開始する
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.headerReferenceSize = CGSizeMake(10, 10)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 5.0
		
//		let collectFrame: CGRect = CGRectMake(10, self.view.frame.origin.y, self.view.frame.size.width - 10*2, self.view.frame.size.height)
		
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        myCollectionView = UICollectionView(frame: collectFrame, collectionViewLayout: layout)
        myCollectionView.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(myCollectionView)
		
		self.navigationItem.title = "PhotoCollection"
		let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain , target: self, action: "popView:")
		self.navigationItem.rightBarButtonItem = cancelButton
        
        // Do any additional setup after loading the view.
    }
	
	func popView(sender: UIBarButtonItem) {
		self.dismissViewControllerAnimated(true, completion: nil)
		self.delegate.showsID = 0
		self.delegate.categoryID = 0
		self.delegate.ageID = 0
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // セルが選択されたときに呼ばれる
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        print(indexPath)
        self.delegate.pictureID = photosArr[indexPath.row].id
        let photoView: PhotoViewController = PhotoViewController()
        self.navigationController?.pushViewController(photoView, animated: true)
        
    }
    
    // Cellのタイプを設定する
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        // let image: UIImage = UIImage(named: "smile.png")!
        // TODO: 今はプロジェクトから参照しているので、できるだけDBから掴んで持ってくること！
        let image: UIImage = UIImage(named: photosArr[indexPath.row].photoName)!
//        print(photosArr[indexPath.row].photoName)
        cell.setImage(image)

        return cell
    }
    
    // Cellの数を設定する
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosArr.count
    }
    
    override func viewWillAppear(animated: Bool) {
        let realm = try! Realm()
        // 押されたボタンが現在地で探すのとき
		photosArr = []
		if self.delegate.showsID != -1 {
            let photos = realm.objects(Photo)
            if self.delegate.showsID == 0 {
                var diffArr: [CGFloat] = []
                let myLocation: CGPoint = CGPoint(x: 90, y: self.longitude)
    //            let myLocation: CGPoint = CGPoint(x: self.latitude, y: self.longitude)
                for photo in photos {
                    let photoLocation: CGPoint = CGPoint(x: photo.latitude, y: photo.longitude)
                    let distance = (photoLocation - myLocation).length
                    diffArr.append(distance)
                    photosArr.append(photo)
                }
                for i in 0..<diffArr.count {
                    for j in 1..<diffArr.count {
                        if diffArr[i] > diffArr[j] {
                            let tmp: CGFloat = diffArr[i]
                            diffArr[i] = diffArr[j]
                            diffArr[j] = tmp
                            let tmpPhoto: Photo = photosArr[i]
                            photosArr[i] = photosArr[j]
                            photosArr[j] = tmpPhoto
                        }
                    }
                }
				print("###############")
				for photo in photosArr {
					print(photo.name)
				}
				
				print("###############")
            }
            // 押されたボタンが場所で探すのとき
            else if self.delegate.showsID < 4 {
                for photo in photos.filter("place == \(self.delegate.showsID! - 1)") {
                    photosArr.append(photo)
                }
            }
		} else if self.delegate.categoryID != -1 {
			let photos = realm.objects(Photo).filter("category == \(self.delegate.categoryID)")
			for photo in photos {
				self.photosArr.append(photo)
			}
		} else {
			let photos = realm.objects(Photo).filter("age == \(self.delegate.ageID)")
			for photo in photos {
				self.photosArr.append(photo)
			}
		}
		
    }
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(100, 100)
	}
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
        // 取得した緯度がnewLocation.coordinate.longitudeに格納されている
        let lat = newLocation.coordinate.latitude
        // 取得した経度がnewLocation.coordinate.longitudeに格納されている
        let long = newLocation.coordinate.longitude
        // 取得した緯度・経度をLogに表示
//        print("latiitude: \(lat) , longitude: \(long)")
		
        // GPSの使用を停止する．停止しない限りGPSは実行され，指定間隔で更新され続ける．
         lm.stopUpdatingLocation()
    }
    
    /* 位置情報取得失敗時に実行される関数 */
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        // この例ではLogにErrorと表示するだけ．
        print("Error")
    }
	
	override func viewWillDisappear(animated: Bool) {
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
