//
//  ViewController.swift
//  TestResizeAnimationDirection
//
//  Created by gongkai on 16/3/17.
//  Copyright © 2016年 mokai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.redColor()
        let bgView = UIView()
        bgView.backgroundColor = UIColor.blackColor()
        bgView.frame.size = CGSizeMake(200, 200)
        bgView.center = self.view.center
        self.view.addSubview(bgView)
        self.view.addSubview(view)
        return view
    }()
    @IBOutlet weak var signleSC: UISegmentedControl!
    @IBOutlet weak var multipleSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = redView
        resetFrame()
    }
    
    @IBAction func onChange(sender: UISegmentedControl) {
        var direction = ResizeDirection.Up
        if signleSC == sender {
            multipleSC.selectedSegmentIndex = UISegmentedControlNoSegment
            if sender.selectedSegmentIndex == 0 {
                direction = .Up
            } else if sender.selectedSegmentIndex == 1 {
                direction = .Down
            } else if sender.selectedSegmentIndex == 2 {
                direction = .Left
            } else if sender.selectedSegmentIndex == 3 {
                direction = .Right
            }
        } else if multipleSC == sender {
             signleSC.selectedSegmentIndex = UISegmentedControlNoSegment
            if sender.selectedSegmentIndex == 0 {
                direction = .UpLeft
            } else if sender.selectedSegmentIndex == 1 {
                direction = .UpRight
            } else if sender.selectedSegmentIndex == 2 {
                direction = .DownLeft
            } else if sender.selectedSegmentIndex == 3 {
                direction = .DownRight
            }
        }
        redView.layer.resizeTo(direction, size: CGSize(width: redView.frame.size.width / 2, height: redView.frame.size.height / 2))

    }
    
    func resetFrame() {
        redView.frame.size = CGSizeMake(200, 200)
        redView.center = self.view.center
    }
    
    @IBAction func onRestFrame(sender: UIButton) {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.resetFrame()
        }
        
    }
}





