//
//  PhotoCollectionViewCell.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2015/12/09.
//  Copyright © 2015年 TubeRiding. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var photo: UIImageView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        let image: UIImage?
        image = UIImage(named: "smile.png")!
        
        photo = UIImageView(image: image)
        photo!.frame = CGRectMake(0, 0, frame.width, frame.height)
        
//        self.contentView.addSubview(photo!)
        self.addSubview(photo!)
    }
    
    override func drawRect(rect: CGRect) {
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1.0
    }
    
    func setImage(image: UIImage) {
        photo!.image = image
    }
    
}
