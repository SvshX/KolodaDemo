//
//  CustomKolodaView.swift
//  KolodaDemo
//
//  Created by Sascha Melcher on 24/03/2016.
//  Copyright © 2016 Locals Labs. All rights reserved.
//

import UIKit
import Koloda

let defaultBottomOffset:CGFloat = 0
let defaultTopOffset:CGFloat = 20
let defaultHorizontalOffset:CGFloat = 10
let defaultHeightRatio:CGFloat = 1.25
let backgroundCardHorizontalMarginMultiplier:CGFloat = 0.25
let backgroundCardScalePercent:CGFloat = 1.5

class CustomKolodaView: KolodaView {
    
    override func frameForCardAtIndex(index: UInt) -> CGRect {
        if index == 0 {
            let topOffset:CGFloat = defaultTopOffset
            let xOffset:CGFloat = defaultHorizontalOffset
            let width = CGRectGetWidth(self.frame ) - 2 * defaultHorizontalOffset
            let height = width * defaultHeightRatio
            let yOffset:CGFloat = topOffset
            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
            
            return frame
        } else if index == 1 {
            let horizontalMargin = -self.bounds.width * backgroundCardHorizontalMarginMultiplier
            let width = self.bounds.width * backgroundCardScalePercent
            let height = width * defaultHeightRatio
            return CGRect(x: horizontalMargin, y: 0, width: width, height: height)
        }
        return CGRectZero
    }
    
}
