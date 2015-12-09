//
//  InfomationViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/10.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit
import RealmSwift

class InfomationViewController: UIViewController, UIWebViewDelegate {
    let webView: UIWebView = UIWebView()
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self;
        self.webView.frame = self.view.bounds
        self.view.addSubview(self.webView)
        
        let realm = try! Realm()
        let photo = realm.objects(Photo).filter("id == \(self.delegate.pictureID)").first!
        let url: NSURL = NSURL(string: photo.url)!
        let urlRequest: NSURLRequest = NSURLRequest(URL: url)
        self.webView.loadRequest(urlRequest)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
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
