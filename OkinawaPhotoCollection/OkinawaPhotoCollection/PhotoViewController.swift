//
//  PhotoViewController.swift
//  OkinawaphotoViewCollection
//
//  Created by aokabin on 2015/12/09.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoViewController: UIViewController {
    private var beforePoint = CGPointMake(0.0, 0.0)
    private var currentScale:CGFloat = 1.0
    let photoView: UIImageView = UIImageView()
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        let realm = try! Realm()
        let photo = realm.objects(Photo).filter("id == \(self.delegate.pictureID)").first
        let image: UIImage = UIImage(named: photo!.photoName)!
        photoView.image = image
        photoView.contentMode = UIViewContentMode.ScaleAspectFit
        photoView.userInteractionEnabled = true
        photoView.frame = CGRectMake(10, 64, self.view.bounds.width - 20, self.view.bounds.height - 104)
        self.view.addSubview(photoView)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "handleGesture:")
        self.photoView.addGestureRecognizer(pinchGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleGesture:")
        self.photoView.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleGesture:")
        self.photoView.addGestureRecognizer(longPressGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "handleGesture:")
        self.photoView.addGestureRecognizer(panGesture)

        // Do any additional setup after loading the view.
    }
    
    func handleGesture(gesture: UIGestureRecognizer){
        if let tapGesture = gesture as? UITapGestureRecognizer{
            tap(tapGesture)
        }else if let pinchGesture = gesture as? UIPinchGestureRecognizer{
            pinch(pinchGesture)
        }else if let longPressGesture = gesture as? UILongPressGestureRecognizer{
            longPress(longPressGesture)
        }else if let panGesture = gesture as? UIPanGestureRecognizer{
            pan(panGesture)
        }
    }
    
    private func pan(gesture:UIPanGestureRecognizer){
        if self.currentScale != 1.0 {
            var translation = gesture.translationInView(self.view)
            
            if abs(self.beforePoint.x) > 0.0 || abs(self.beforePoint.y) > 0.0{
                translation = CGPointMake(self.beforePoint.x + translation.x, self.beforePoint.y + translation.y)
            }
            
            switch gesture.state{
            case .Changed:
                let scaleTransform = CGAffineTransformMakeScale(self.currentScale, self.currentScale)
                let translationTransform = CGAffineTransformMakeTranslation(translation.x, translation.y)
                self.photoView.transform = CGAffineTransformConcat(scaleTransform, translationTransform)
            case .Ended , .Cancelled:
                self.beforePoint = translation
            default:
                NSLog("no action")
            }
        }
    }
    
    private func longPress(gesture:UILongPressGestureRecognizer){
        if gesture.state == .Began{
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.currentScale = 1.0
                self.beforePoint = CGPointMake(0.0, 0.0)
                self.photoView.transform = CGAffineTransformIdentity
            })
        }
    }
    
    private func tap(gesture:UITapGestureRecognizer){
        if self.currentScale == 1.0 {
            let alertController: UIAlertController = UIAlertController(title: "行動選択", message: "お店の情報を見ますか？ルートを表示しますか？", preferredStyle: .Alert)
            let infoAction = UIAlertAction(title: "情報を見る", style: .Default, handler: { action in
                // TODO: InformationViewControllerとかに変える
                let infomationView: InfomationViewController = InfomationViewController()
                self.navigationController?.pushViewController(infomationView, animated: true)
            })
            let routeAction = UIAlertAction(title: "ルートを表示する", style: .Default, handler: { action in
                // TODO: RouteViewControllerとかに変える
                let routeView: RouteViewController = RouteViewController()
                self.navigationController?.pushViewController(routeView, animated: true)
            })
            let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel, handler: { action in
                print("Canceled!")
            })
            alertController.addAction(infoAction)
            alertController.addAction(routeAction)
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.currentScale = 1.0
                self.beforePoint = CGPointMake(0.0, 0.0)
                self.photoView.transform = CGAffineTransformIdentity
            })
        }
    }
    
    private func pinch(gesture:UIPinchGestureRecognizer){
        var scale = gesture.scale
        if self.currentScale > 1.0{
            scale = self.currentScale + (scale - 1.0)
        }
        switch gesture.state{
        case .Changed:
            let scaleTransform = CGAffineTransformMakeScale(scale, scale)
            let transitionTransform = CGAffineTransformMakeTranslation(self.beforePoint.x, self.beforePoint.y)
            self.photoView.transform = CGAffineTransformConcat(scaleTransform, transitionTransform)
        case .Ended , .Cancelled:
            if scale <= 1.0{
                self.currentScale = 1.0
                self.photoView.transform = CGAffineTransformIdentity
            }else{
                self.currentScale = scale
            }
        default:
            NSLog("not action")
        }
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
