//
//  TopTabViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/09.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit

class TopTabViewController: UITabBarController {
    
    let locationView: LocationViewController = LocationViewController()
    let placeSelectView: PlaceSelectViewController = PlaceSelectViewController()
    let purposeSelectView: PurposeSelectViewController = PurposeSelectViewController()
    let ageSelectView: AgeSelectViewController = AgeSelectViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 1)
        placeSelectView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 2)
        purposeSelectView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 3)
        ageSelectView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 4)
        let tabs: [UIViewController] = NSArray(objects: self.locationView, self.placeSelectView, self.purposeSelectView, self.ageSelectView) as! [UIViewController]
        self.setViewControllers(tabs, animated: true)
        self.selectedViewController! = locationView
        self.automaticallyAdjustsScrollViewInsets = false

        // Do any additional setup after loading the view.
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
