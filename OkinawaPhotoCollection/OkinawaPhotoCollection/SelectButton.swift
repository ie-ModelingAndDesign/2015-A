//
//  SelectButton.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 1/6/16.
//  Copyright © 2016 TubeRiding. All rights reserved.
//

import UIKit

class SelectButton: UIView {
	var backgroundImage: UIImageView = UIImageView()
	var titleLabel: UILabel = UILabel()
	
	init() {
		super.init(frame: CGRectZero)
		self.userInteractionEnabled = true
		backgroundImage.image = UIImage(named: "sample.jpg")
		titleLabel.text = "Sample"
	}
	
	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func drawRect(rect: CGRect) {
		
	}
	
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
