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
		
//		let scrollView: UIScrollView = UIScrollView()
		let btnMarginTop: CGFloat = 10
		let btnX: CGFloat = 10
		let btnWth: CGFloat = UIScreen.mainScreen().bounds.size.width - btnX*2
		let btnHth: CGFloat = (UIScreen.mainScreen().bounds.size.height - 64) / 2 - (btnMarginTop)
		
//		scrollView.pagingEnabled = false
//		scrollView.scrollEnabled = true
//		scrollView.frame = CGRectMake(0, 0, btnWth, self.view.bounds.height - 64)
//		scrollView.showsVerticalScrollIndicator = true
//		scrollView.showsHorizontalScrollIndicator = false
//		scrollView.scrollsToTop = true
//		scrollView.contentSize = CGSizeMake(btnWth, btnHth * 2 + 64)
		
		showPhotosButtonNowLocation.backgroundColor = UIColor.blackColor()
		showPhotosButtonNowLocation.tag = 0
		showPhotosButtonNowLocation.frame = CGRectMake(btnX, btnMarginTop, btnWth - (btnX*2),btnHth)
		let nowLocationImage: UIImage = UIImage(named: "activity.png")!
		let nowLocationImageView: UIImageView = UIImageView(image: nowLocationImage)
		nowLocationImageView.alpha = 0.8
		nowLocationImageView.frame = CGRectMake(0, 0, btnWth, btnHth)
		showPhotosButtonNowLocation.addSubview(nowLocationImageView)
		let nowLocationLabel: UILabel = UILabel()
		nowLocationLabel.text = "アクティビティーから探す"
		nowLocationLabel.textColor = UIColor.whiteColor()
		nowLocationLabel.textAlignment = .Center
		nowLocationLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
		let labelSize: CGSize = CGSizeMake(btnWth, 20)
		nowLocationLabel.frame = CGRectMake(btnWth / 2 - (labelSize.width / 2), btnHth / 2 - (labelSize.height / 2), labelSize.width, labelSize.height)
		showPhotosButtonNowLocation.addSubview(nowLocationLabel)
		showPhotosButtonNowLocation.bringSubviewToFront(nowLocationLabel)
		
		self.view.addSubview(showPhotosButtonNowLocation)
//		scrollView.addSubview(showPhotosButtonNowLocation)
		
		showPhotosButtonNorth.backgroundColor = UIColor.blackColor()
		showPhotosButtonNorth.tag = 1
		showPhotosButtonNorth.frame = CGRectMake(btnX, showPhotosButtonNowLocation.frame.origin.y + showPhotosButtonNowLocation.frame.size.height + btnMarginTop, btnWth - (btnX*2),btnHth)
		let northImage: UIImage = UIImage(named: "food.png")!
		let northImageView: UIImageView = UIImageView(image: northImage)
		northImageView.alpha = 0.8
		northImageView.frame = CGRectMake(0, 0, btnWth, btnHth)
		showPhotosButtonNorth.addSubview(northImageView)
		let northLabel: UILabel = UILabel()
		northLabel.text = "食事から探す"
		northLabel.textColor = UIColor.whiteColor()
		northLabel.textAlignment = .Center
		northLabel.frame = CGRectMake(btnWth / 2 - (labelSize.width / 2), btnHth / 2 - (labelSize.height / 2), labelSize.width, labelSize.height)
		northLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
		showPhotosButtonNorth.addSubview(northLabel)
		showPhotosButtonNorth.bringSubviewToFront(northLabel)
//		scrollView.addSubview(showPhotosButtonNorth)
		self.view.addSubview(showPhotosButtonNorth)
		
//		self.view.addSubview(scrollView)
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let sender: UITouch = touches.first!
		print(sender.view!.tag)
		self.delegate.showsID = -1
		self.delegate.categoryID = sender.view!.tag
		self.delegate.ageID = -1
		
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
