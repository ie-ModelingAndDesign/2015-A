//
//  SecondViewController.swift
//  UIKit013
//
//

import UIKit

class SecindViewController: UIViewController, TabBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didSelectTab(tabBarController: TabBarController) {
        print("second!")
    }
}
