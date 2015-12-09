//
//  ViewController.swift
//  testcollec
//
//  Created by 宮里　悠太郎 on 2015/11/26.
//  Copyright © 2015年 hoge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    class MasterViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        // MARK: - UICollectionViewDelegate Protocol
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell:CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
            cell.title.text = "タイトル";
            cell.image.image = UIImage(named: "smile.png")
            cell.backgroundColor = UIColor.blackColor()
            return cell
        }
        
        func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 20;
        }
    }

}

