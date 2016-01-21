//
//  PurposeSelectViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/09.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit
import CoreLocation

class PurposeSelectViewController: UIViewController, CLLocationManagerDelegate {
	//    let lm: CLLocationManager = CLLocationManager()
	//    let latitude: CLLocationDegrees = CLLocationDegrees()
	//    let longitude: CLLocationDegrees = CLLocationDegrees()
	let showPhotosButtonNowLocation: UIView = UIView()
	let showPhotosButtonNorth: UIView = UIView()
	
	let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
	
	override func viewDidLoad() {
		super.viewDidLoad()
		putButtons()
		
		// Do any additional setup after loading the view.
	}
	
	func putButtons() {
		showPhotosButtonNowLocation.userInteractionEnabled = true
		showPhotosButtonNorth.userInteractionEnabled = true
		
		let btnWth: CGFloat = UIScreen.mainScreen().bounds.size.width
		let btnHth: CGFloat = (UIScreen.mainScreen().bounds.size.height - 64) / 2
		let btnX: CGFloat = 0
		showPhotosButtonNowLocation.backgroundColor = UIColor.blackColor()
		showPhotosButtonNowLocation.tag = 0
		showPhotosButtonNowLocation.frame = CGRectMake(btnX, 0, btnWth,btnHth)
		let nowLocationImage: UIImage = UIImage(named: "nowLocation.png")!
		let nowLocationImageView: UIImageView = UIImageView(image: nowLocationImage)
		nowLocationImageView.alpha = 0.7
		nowLocationImageView.frame = CGRectMake(0, 0, btnWth, btnHth)
		showPhotosButtonNowLocation.addSubview(nowLocationImageView)
		let nowLocationLabel: UILabel = UILabel()
		nowLocationLabel.text = "現在地から探す"
		nowLocationLabel.textColor = UIColor.whiteColor()
		nowLocationLabel.textAlignment = .Center
		nowLocationLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
		let labelSize: CGSize = CGSizeMake(btnWth, 20)
		nowLocationLabel.frame = CGRectMake(btnWth / 2 - (labelSize.width / 2), btnHth / 2 - (labelSize.height / 2), labelSize.width, labelSize.height)
		showPhotosButtonNowLocation.addSubview(nowLocationLabel)
		showPhotosButtonNowLocation.bringSubviewToFront(nowLocationLabel)
		
		self.view.addSubview(showPhotosButtonNowLocation)
		
		showPhotosButtonNorth.backgroundColor = UIColor.blackColor()
		showPhotosButtonNorth.tag = 1
		showPhotosButtonNorth.frame = CGRectMake(btnX, showPhotosButtonNowLocation.frame.origin.y + showPhotosButtonNowLocation.frame.size.height, btnWth,btnHth)
		let northImage: UIImage = UIImage(named: "north.png")!
		let northImageView: UIImageView = UIImageView(image: northImage)
		northImageView.alpha = 0.7
		northImageView.frame = CGRectMake(0, 0, btnWth, btnHth)
		showPhotosButtonNorth.addSubview(northImageView)
		let northLabel: UILabel = UILabel()
		northLabel.text = "北部から探す"
		northLabel.textColor = UIColor.whiteColor()
		northLabel.textAlignment = .Center
		northLabel.frame = CGRectMake(btnWth / 2 - (labelSize.width / 2), btnHth / 2 - (labelSize.height / 2), labelSize.width, labelSize.height)
		northLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
		showPhotosButtonNorth.addSubview(northLabel)
		showPhotosButtonNorth.bringSubviewToFront(northLabel)
		self.view.addSubview(showPhotosButtonNorth)
		
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let sender: UITouch = touches.first!
		print(sender.view!.tag)
		self.delegate.showsID = sender.view!.tag
		
		let photos: PhotoCollectionViewController = PhotoCollectionViewController()
		let myNavi: UINavigationController = UINavigationController(rootViewController: photos)
		self.view.window?.rootViewController!.presentViewController(myNavi, animated: true, completion: nil)
	}
	
	func showPhotos(sender: UIButton) {
		self.delegate.showsID = sender.tag
		
		let photos: PhotoCollectionViewController = PhotoCollectionViewController()
		let myNavi: UINavigationController = UINavigationController(rootViewController: photos)
		self.view.window?.rootViewController!.presentViewController(myNavi, animated: true, completion: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	override func viewWillAppear(animated: Bool) {
		//        putButtons()
		//		self.navigationController!.setNavigationBarHidden(false, animated: true)
		//		self.setNeedsStatusBarAppearanceUpdate()
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
