//
//  CALayer+ResizeAnimationDirection.swift
//  TestResizeAnimationDirection
//
//  Created by gongkai on 16/3/17.
//  Copyright © 2016年 mokai. All rights reserved.
//

import UIKit

struct ResizeDirection: OptionSetType {
    let rawValue: UInt
    static let Up  = ResizeDirection(rawValue:1)
    static let Down  = ResizeDirection(rawValue:2)
    static let Left = ResizeDirection(rawValue:4)
    static let Right = ResizeDirection(rawValue:8)
    
    static let UpLeft : ResizeDirection = [Up,Left]
    static let UpRight : ResizeDirection = [Up,Right]
    static let DownLeft : ResizeDirection = [Down,Left]
    static let DownRight : ResizeDirection = [Down, Right]
}

extension CALayer {
    /**
     In the direction of the resize
     
     - parameter direction: see ResizeDirection
     - parameter size: target size
     - parameter size: animation duration
     */
    func resizeTo(direction: ResizeDirection, size: CGSize, animationDuration: NSTimeInterval = 0.3) {
        guard !CGSizeEqualToSize(size, self.frame.size) else {
            return
        }
        
        var anchorPoint = self.anchorPoint
        if direction == ResizeDirection.Up {
            anchorPoint.y = 0
        } else if direction == ResizeDirection.Down {
            anchorPoint.y = 1
        } else if direction == ResizeDirection.Left {
            anchorPoint.x = 0
        } else if direction == ResizeDirection.Right {
            anchorPoint.x = 1
        } else if direction == ResizeDirection.UpLeft {
            anchorPoint.x = 0
            anchorPoint.y = 0
        } else if direction == ResizeDirection.UpRight {
            anchorPoint.x = 1
            anchorPoint.y = 0
        } else if direction == ResizeDirection.DownLeft {
            anchorPoint.x = 0
            anchorPoint.y = 1
        } else if direction == ResizeDirection.DownRight {
            anchorPoint.x = 1
            anchorPoint.y = 1
        }
        
        var frame = self.frame
        let oldAnchorPoint = self.anchorPoint
        let fixPosition = CGPointMake(frame.origin.x + anchorPoint.x * frame.size.width, frame.origin.y + anchorPoint.y * frame.size.height)
        self.anchorPoint = anchorPoint
        self.position = fixPosition
        
        let targetScalePoint = CGPointMake(size.width / frame.width , size.height / frame.height)
        UIView.animateWithDuration(animationDuration, animations: {[unowned self] () -> Void in
            self.transform = CATransform3DMakeScale(targetScalePoint.x, targetScalePoint.y, 1) //只有使用scale才能实现View大小改变并且不平移
            }) { (isFinshed) -> Void in
                //reset
                frame = self.frame
                self.transform = CATransform3DIdentity
                let position = CGPointMake(frame.origin.x + oldAnchorPoint.x * frame.size.width, frame.origin.y + oldAnchorPoint.y * frame.size.height)
                self.anchorPoint = oldAnchorPoint
                self.position = position
                self.frame = frame
                
        }
    }
}
