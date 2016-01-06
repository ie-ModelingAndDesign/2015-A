//
//  PlaceSelectViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/09.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit
import CoreLocation

class PlaceSelectViewController: UIViewController, CLLocationManagerDelegate  {

//    let lm: CLLocationManager = CLLocationManager()
//    let latitude: CLLocationDegrees = CLLocationDegrees()
//    let longitude: CLLocationDegrees = CLLocationDegrees()
    let showPhotosButtonNowLocation: UIView = UIView()
    let showPhotosButtonNorth: UIView = UIView()
    let showPhotosButtonMiddle: UIView = UIView()
    let showPhotosButtonSouth: UIView = UIView()
//    let showPhotosButtonSouth: UIButton = UIButton()
	
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
	
    override func viewDidLoad() {
        super.viewDidLoad()
//		self.presentViewController(UIViewController(), animated: false, completion: nil)
//		self.dismissViewControllerAnimated(false, completion: nil)
		putButtons()
		
        // Do any additional setup after loading the view.
    }
    
	func putButtons() {
		showPhotosButtonNowLocation.userInteractionEnabled = true
		showPhotosButtonNorth.userInteractionEnabled = true
		showPhotosButtonMiddle.userInteractionEnabled = true
		showPhotosButtonSouth.userInteractionEnabled = true

        let btnWth: CGFloat = UIScreen.mainScreen().bounds.size.width
        let btnHth: CGFloat = (UIScreen.mainScreen().bounds.size.height - 64) / 4
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
        
        showPhotosButtonMiddle.backgroundColor = UIColor.blackColor()
        showPhotosButtonMiddle.tag = 2
        showPhotosButtonMiddle.frame = CGRectMake(btnX, showPhotosButtonNorth.frame.origin.y + showPhotosButtonNorth.frame.size.height, btnWth,btnHth)
		let middleImage: UIImage = UIImage(named: "middle.png")!
		let middleImageView: UIImageView = UIImageView(image: middleImage)
		middleImageView.alpha = 0.7
		middleImageView.frame = CGRectMake(0, 0, btnWth, btnHth)
		showPhotosButtonMiddle.addSubview(middleImageView)
		let middleLabel: UILabel = UILabel()
		middleLabel.text = "中部から探す"
		middleLabel.textColor = UIColor.whiteColor()
		middleLabel.textAlignment = .Center
		middleLabel.frame = CGRectMake(btnWth / 2 - (labelSize.width / 2), btnHth / 2 - (labelSize.height / 2), labelSize.width, labelSize.height)
		middleLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
		showPhotosButtonMiddle.addSubview(middleLabel)
		showPhotosButtonMiddle.bringSubviewToFront(middleLabel)
        self.view.addSubview(showPhotosButtonMiddle)

        showPhotosButtonSouth.backgroundColor = UIColor.blackColor()
        showPhotosButtonSouth.tag = 3
        showPhotosButtonSouth.frame = CGRectMake(btnX, showPhotosButtonMiddle.frame.origin.y + showPhotosButtonMiddle.frame.size.height, btnWth,btnHth)
		let southImage: UIImage = UIImage(named: "south.png")!
		let southImageView: UIImageView = UIImageView(image: southImage)
		southImageView.alpha = 0.7
		southImageView.frame = CGRectMake(0, 0, btnWth, btnHth)
		showPhotosButtonSouth.addSubview(southImageView)
		let southLabel: UILabel = UILabel()
		southLabel.text = "南部から探す"
		southLabel.textColor = UIColor.whiteColor()
		southLabel.textAlignment = .Center
		southLabel.frame = CGRectMake(btnWth / 2 - (labelSize.width / 2), btnHth / 2 - (labelSize.height / 2), labelSize.width, labelSize.height)
		southLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
		showPhotosButtonSouth.addSubview(southLabel)
		showPhotosButtonSouth.bringSubviewToFront(southLabel)
//		showPhotosButtonSouth.sendSubviewToBack(southImageView)
//		self.view.bringSubviewToFront(southLabel)
//        showPhotosButtonSouth.setTitle("南部から探す", forState: .Normal)
//        showPhotosButtonSouth.addTarget(self, action: "showPhotos:", forControlEvents: .TouchUpInside)
        self.view.addSubview(showPhotosButtonSouth)
    }
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let sender: UITouch = touches.first!
		print(sender.view!.tag)
        self.delegate.showsID = sender.view!.tag
		
        let photos: PhotoCollectionViewController = PhotoCollectionViewController()
		let myNavi: UINavigationController = UINavigationController(rootViewController: photos)
//		self.view.window?.rootViewController!.prese
		self.view.window?.rootViewController!.presentViewController(myNavi, animated: true, completion: nil)
	}
    
    func showPhotos(sender: UIButton) {
//		print(sender.tag)
        self.delegate.showsID = sender.tag
		
        let photos: PhotoCollectionViewController = PhotoCollectionViewController()
		let myNavi: UINavigationController = UINavigationController(rootViewController: photos)
//		self.view.window?.rootViewController!.prese
		self.view.window?.rootViewController!.presentViewController(myNavi, animated: true, completion: nil)
//		self.presentViewController(myNavi, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	override func viewWillAppear(animated: Bool) {
        putButtons()
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
