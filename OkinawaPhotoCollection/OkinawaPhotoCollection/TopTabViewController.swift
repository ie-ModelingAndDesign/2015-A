//
//  TopTabViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/09.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit
import RealmSwift
import PageMenu

class TopTabViewController: UITabBarController, CAPSPageMenuDelegate {
    
    let placeSelectView: PlaceSelectViewController = PlaceSelectViewController()
    let purposeSelectView: PurposeSelectViewController = PurposeSelectViewController()
    let ageSelectView: AgeSelectViewController = AgeSelectViewController()
	
	var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
		var controllerArray: [UIViewController] = []
		placeSelectView.title = "PLACE"
		controllerArray.append(placeSelectView)
		purposeSelectView.title = "PURPOSE"
		controllerArray.append(purposeSelectView)
		ageSelectView.title = "AGE"
		controllerArray.append(ageSelectView)
		
		let parameters: [CAPSPageMenuOption] = [
			.MenuItemSeparatorWidth(4.3),
			.UseMenuLikeSegmentedControl(true),
			.ViewBackgroundColor(UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)),
			.SelectionIndicatorColor(UIColor.orangeColor()),
			.MenuHeight(44),
			.MenuItemWidthBasedOnTitleTextWidth(true),
			.MenuItemSeparatorPercentageHeight(0.1)
		]
		
		let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
		let viewWidth = self.view.frame.width
		let viewHeight = self.view.frame.height
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0, statusBarHeight, viewWidth, viewHeight - statusBarHeight), pageMenuOptions: parameters)
		pageMenu!.delegate = self
		
		self.view.addSubview(pageMenu!.view)
		
		let insdata = ImportDatas()
		print(insdata.run())
		
		
//        placeSelectView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 1)
//        purposeSelectView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 2)
//        ageSelectView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 3)
//        let tabs: [UIViewController] = NSArray(objects: self.placeSelectView, self.purposeSelectView, self.ageSelectView) as! [UIViewController]
//        self.setViewControllers(tabs, animated: true)
//        self.selectedViewController! = placeSelectView
//        self.automaticallyAdjustsScrollViewInsets = false
//        
//        if !NSFileManager.defaultManager().fileExistsAtPath(Realm.Configuration.defaultConfiguration.path!) {
//            let insData = ImportDatas()
//            print(insData.run())
//            
//        } else {
//            print("Not Copy!")
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(animated: Bool) {
		self.navigationController!.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewDidAppear(animated: Bool) {
//		self.setNeedsStatusBarAppearanceUpdate()
		print(pageMenu!.view.frame)
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
