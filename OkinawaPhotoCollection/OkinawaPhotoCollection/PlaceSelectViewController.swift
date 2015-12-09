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

    let lm: CLLocationManager = CLLocationManager()
    let latitude: CLLocationDegrees = CLLocationDegrees()
    let longitude: CLLocationDegrees = CLLocationDegrees()
    let showPhotosButtonNowLocation: UIButton = UIButton()
    let showPhotosButtonNorth: UIButton = UIButton()
    let showPhotosButtonMiddle: UIButton = UIButton()
    let showPhotosButtonSouth: UIButton = UIButton()
    
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        putButtons()
        // Do any additional setup after loading the view.
    }
    
    func putButtons() {
        let btnWth: CGFloat = 300
        let btnHth: CGFloat = 100
        let btnX: CGFloat = 10
        showPhotosButtonNowLocation.backgroundColor = UIColor.blueColor()
        showPhotosButtonNowLocation.setTitle("現在地から探す", forState: .Normal)
        showPhotosButtonNowLocation.addTarget(self, action: "showPhotos:", forControlEvents: .TouchUpInside)
        showPhotosButtonNowLocation.tag = 0
        showPhotosButtonNowLocation.frame = CGRectMake(btnX, 50, btnWth,btnHth)
        self.view.addSubview(showPhotosButtonNowLocation)
        
        showPhotosButtonNorth.backgroundColor = UIColor.blueColor()
        showPhotosButtonNorth.setTitle("北部から探す", forState: .Normal)
        showPhotosButtonNorth.addTarget(self, action: "showPhotos:", forControlEvents: .TouchUpInside)
        showPhotosButtonNorth.tag = 1
        showPhotosButtonNorth.frame = CGRectMake(btnX, showPhotosButtonNowLocation.frame.origin.y + showPhotosButtonNowLocation.frame.size.height + 20, btnWth,btnHth)
        self.view.addSubview(showPhotosButtonNorth)
        
        showPhotosButtonMiddle.backgroundColor = UIColor.blueColor()
        showPhotosButtonMiddle.setTitle("中部から探す", forState: .Normal)
        showPhotosButtonMiddle.addTarget(self, action: "showPhotos:", forControlEvents: .TouchUpInside)
        showPhotosButtonMiddle.tag = 2
        showPhotosButtonMiddle.frame = CGRectMake(btnX, showPhotosButtonNorth.frame.origin.y + showPhotosButtonNorth.frame.size.height + 20, btnWth,btnHth)
        self.view.addSubview(showPhotosButtonMiddle)
        
        showPhotosButtonSouth.backgroundColor = UIColor.blueColor()
        showPhotosButtonSouth.setTitle("南部から探す", forState: .Normal)
        showPhotosButtonSouth.addTarget(self, action: "showPhotos:", forControlEvents: .TouchUpInside)
        showPhotosButtonSouth.tag = 3
        showPhotosButtonSouth.frame = CGRectMake(btnX, showPhotosButtonMiddle.frame.origin.y + showPhotosButtonMiddle.frame.size.height + 20, btnWth,btnHth)
        self.view.addSubview(showPhotosButtonSouth)
    }
    
    func showPhotos(sender: UIButton) {
        self.delegate.showsID = sender.tag
        
        let photos: PhotoCollectionViewController = PhotoCollectionViewController()
        self.navigationController?.pushViewController(photos, animated: true)
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
