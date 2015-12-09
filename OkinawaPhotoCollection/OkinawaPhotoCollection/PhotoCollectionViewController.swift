//
//  PhotoViewController.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/09.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var myCollectionView: UICollectionView!
    var photosArr: [Photo] = []
    
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.headerReferenceSize = CGSizeMake(10, 28)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(myCollectionView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // セルが選択されたときに呼ばれる
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        self.delegate.pictureID = photosArr[indexPath.row].id
        let photoView: PhotoViewController = PhotoViewController()
        self.navigationController?.pushViewController(photoView, animated: true)
        
    }
    
    // Cellのタイプを設定する
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        // let image: UIImage = UIImage(named: "smile.png")!
        // TODO: 今はプロジェクトから参照しているので、できるだけDBから掴んで持ってくること！
        let image: UIImage = UIImage(named: photosArr[indexPath.row].photoName)!
        print(photosArr[indexPath.row].photoName)
        cell.setImage(image)

        return cell
    }
    
    // Cellの数を設定する
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosArr.count
    }
    
    override func viewWillAppear(animated: Bool) {
        let realm = try! Realm()
        let photos = realm.objects(Photo)
        // 押されたボタンが現在地で探すのとき
        if self.delegate.showsID == 0 {
            for photo in photos {
                photosArr.append(photo)
            }
            
        }
        // 押されたボタンが場所で探すのとき
        else if self.delegate.showsID < 4 {
            for photo in photos.filter("place == \(self.delegate.showsID! - 1)") {
                photosArr.append(photo)
            }
        }
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
