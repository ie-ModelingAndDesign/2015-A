//
//  PageMenuViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 1/6/16.
//  Copyright © 2016 TubeRiding. All rights reserved.
//

import UIKit

class PageMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		var controllerArray: [UIViewController] = []
		var controller: PlaceSelectViewController = PlaceSelectViewController()
		controller.title = "場所で探す"
		controllerArray.append(controller)

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
