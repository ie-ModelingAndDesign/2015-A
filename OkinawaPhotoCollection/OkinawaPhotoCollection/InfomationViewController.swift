//
//  InfomationViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/10.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit

class InfomationViewController: UIViewController, UIWebViewDelegate {
    let webView: UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self;
        self.webView.frame = self.view.bounds
        self.view.addSubview(self.webView)
        
        //TODO: 今はとりあえず我流屋としている、これはDBからちゃんと取ってくるように!
        let url: NSURL = NSURL(string: "http://tabelog.com/okinawa/A4703/A470404/47010820/")!
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
