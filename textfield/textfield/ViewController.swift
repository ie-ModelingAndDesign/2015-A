//
//  ViewController.swift
//  scrollview_sample
//
//  Created by Keisuke.K on 2015/04/12.
//  Copyright (c) 2015年 Keisuke.K. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate{
    
    let text1: UITextField = UITextField(frame: CGRectMake(0,0,300,30))
    let sc = UIScrollView();
    var txtActiveField = UITextField()
    
    let myTextView: UITextView = UITextView(frame: CGRectMake(10, 50, 400, 500))
    
    
     var myButton: UIButton!
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sc.frame = self.view.frame;
        sc.backgroundColor = UIColor.redColor();
        sc.delegate = self;
        
        //textfileの位置を指定する
        sc.contentSize = CGSize(width: 250,height: 1000)
        self.view.addSubview(sc);
        
        
        
        
        // TextView生成する.
        
        // TextViewの背景を黃色に設定する.
        myTextView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 1, alpha: 1.0)
        
        // 表示させるテキストを設定する.
        myTextView.text = ""
        
        myTextView.editable = false
        // TextViewをViewに追加する.
        self.view.addSubview(myTextView)
        
        
        
        
        // 表示する文字を代入する.
        text1.text = "hoge"
        
        // Delegateを設定する.
        text1.delegate = self
        
        // 枠を表示する.
        text1.borderStyle = UITextBorderStyle.RoundedRect
        
        // UITextFieldの表示する位置を設定する.
        text1.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height - 35);
        
        self.view.addSubview(text1)
        
        // Viewに追加する
        sc.addSubview(text1)
        
        
        
        
        // Buttonを生成する.
        myButton = UIButton()
        
        // サイズを設定する.
        myButton.frame = CGRectMake(0,0,200,40)
        
        // 背景色を設定する.
        myButton.backgroundColor = UIColor.redColor()
        
        // 枠を丸くする.
        myButton.layer.masksToBounds = true
        
        // タイトルを設定する(通常時).
        myButton.setTitle("ボタン(通常)", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        // タイトルを設定する(ボタンがハイライトされた時).
        myButton.setTitle("ボタン(押された時)", forState: UIControlState.Highlighted)
        myButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        
        // コーナーの半径を設定する.
        myButton.layer.cornerRadius = 20.0
        
        // ボタンの位置を指定する.
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        
        // タグを設定する.
        myButton.tag = 1
        
        // イベントを追加する.
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // ボタンをViewに追加する.
        self.view.addSubview(myButton)
        
        
        
        
    }
    
    //改行ボタンが押された際に呼ばれる.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //UITextFieldが編集された直後に呼ばれる.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        txtActiveField = textField
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        var txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        
        print("テキストフィールドの下辺：(\(txtLimit))")
        print("キーボードの上辺：(\(kbdLimit))")
        
        if txtLimit >= kbdLimit {
            sc.contentOffset.y = txtLimit - kbdLimit
        }
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        sc.contentOffset.y = 0
    }
    
    
    
    internal func onClickMyButton(sender: UIButton){
        
        let com = Comment()
    
        var hoge:String = ""
        
        
        com.comment = text1.text!
                
        do{
            let realm = try! Realm()
            var max = realm.objects(Comment).sorted("id",ascending:false)
            com.id = max[0].id + 1
            
            let comments = realm.objects(Comment)
            
            for comment in comments {
                hoge += comment.comment
                hoge += "\n"
                print("\(comment.comment))")
            }
            
            try! realm.write {
                realm.add(com,update: true)
            }
            
            
            myTextView.text = hoge
            print(realm.objects(Comment))
            print(realm.path)
            text1.text = ""
        }catch{
            print("failure")
        }

        
        
        
        
    }
    
    


    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
