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
    
    let lm: CLLocationManager = CLLocationManager()
    let latitude: CLLocationDegrees = CLLocationDegrees()
    let longitude: CLLocationDegrees = CLLocationDegrees()
    let showPhotosButtonNowLocation: UIButton = UIButton()
    let showPhotosButtonNorth: UIButton = UIButton()
    let showPhotosButtonMiddle: UIButton = UIButton()
    let showPhotosButtonSouth: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        var beforeContentFrame: CGRect = CGRect()
        showPhotosButtonNowLocation.backgroundColor = UIColor.blueColor()
        showPhotosButtonNowLocation.setTitle("現在地から探す", forState: .Normal)
        showPhotosButtonNowLocation.addTarget(self, action: "showPhotos:", forControlEvents: .TouchUpInside)
        showPhotosButtonNowLocation.tag = 0
        showPhotosButtonNowLocation.frame = CGRectMake(10, 50, 300, 100)
        self.view.addSubview(showPhotosButtonNowLocation)
        
        beforeContentFrame = showPhotosButtonNowLocation.frame
        
        showPhotosButtonNorth.backgroundColor = UIColor.blueColor()
        showPhotosButtonNorth.setTitle("北部から探す", forState: .Normal)
        showPhotosButtonNorth.addTarget(self, action: "showPhotos:", forControlEvents: .TouchUpInside)
        showPhotosButtonNorth.tag = 1
        showPhotosButtonNorth.frame = CGRectMake(beforeContentFrame.origin.x, beforeContentFrame.origin.y + beforeContentFrame.height + 20, beforeContentFrame.width, beforeContentFrame.height)
        self.view.addSubview(showPhotosButtonNorth)
        
        beforeContentFrame = showPhotosButtonNorth.frame
        
        showPhotosButtonMiddle.backgroundColor = UIColor.blueColor()
        showPhotosButtonMiddle.setTitle("中部から探す", forState: .Normal)
        showPhotosButtonMiddle.addTarget(self, action: "showPhotos:", forControlEvents: .TouchUpInside)
        showPhotosButtonMiddle.tag = 2
        showPhotosButtonMiddle.frame = CGRectMake(beforeContentFrame.origin.x, beforeContentFrame.origin.y + beforeContentFrame.height + 20, beforeContentFrame.width, beforeContentFrame.height)
        self.view.addSubview(showPhotosButtonMiddle)
        
        beforeContentFrame = showPhotosButtonMiddle.frame
        
        showPhotosButtonSouth.backgroundColor = UIColor.blueColor()
        showPhotosButtonSouth.setTitle("南部から探す", forState: .Normal)
        showPhotosButtonSouth.addTarget(self, action: "showPhotos:", forControlEvents: .TouchUpInside)
        showPhotosButtonSouth.tag = 3
        showPhotosButtonMiddle.frame = CGRectMake(beforeContentFrame.origin.x, beforeContentFrame.origin.y + beforeContentFrame.height + 20, beforeContentFrame.width, beforeContentFrame.height)
        self.view.addSubview(showPhotosButtonSouth)
        
        // Do any additional setup after loading the view.
    }
    
    func showPhotos(sender: UIButton) {
//        print(sender.tag)
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
