//
//  UIScrollViewExt.swift
//  OkinawaPhotoCollection
//
//  Created by aokabin on 2/11/16.
//  Copyright © 2016 TubeRiding. All rights reserved.
//

import Foundation
import UIKit

class TouchScrollView: UIScrollView {
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		superview?.touchesBegan(touches, withEvent: event)
	}
}