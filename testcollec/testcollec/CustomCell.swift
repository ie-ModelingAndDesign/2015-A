//
//  CustomCell.swift
//  testcollec
//
//  Created by 宮里　悠太郎 on 2015/11/26.
//  Copyright © 2015年 hoge. All rights reserved.
//

import Foundation

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var title:UILabel!
    @IBOutlet var image:UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
}