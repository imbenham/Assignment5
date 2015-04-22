//
//  FirstViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class FirstViewController: ExerciseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 1"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Create a red box (10px tall, the width of the screen) with a black border on the very top of the screen below the nav bar,
        and a black box with a red border on the very bottom of the screen (same dimensions), above the toolbar.
        
        Use Springs & Struts to lay out these views.
        
        Your view should be in self.exerciseView, not self.view
        */
        
        let topOffset = self.navigationController != nil ? self.navigationController!.navigationBar.frame.maxY : 0
        let bottomOffset = self.toolbar.frame.size.height
        
        let topRect = CGRectMake(0, topOffset, self.exerciseView.frame.size.width, 10.0)
        let bottomRect = CGRectMake(0, self.exerciseView.frame.size.height - (topRect.size.height + bottomOffset), topRect.size.width, topRect.size.height)
        
        let topView = UIView(frame: topRect)
        let bottomView = UIView(frame: bottomRect)
        
        topView.backgroundColor  = UIColor.redColor()
        bottomView.backgroundColor = UIColor.blackColor()
        
        topView.layer.borderWidth = 1.0
        bottomView.layer.borderWidth = 1.0
        topView.layer.borderColor = bottomView.backgroundColor!.CGColor
        bottomView.layer.borderColor = topView.backgroundColor!.CGColor
        
        topView.autoresizingMask  = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        bottomView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight 
        
        self.exerciseView.addSubview(topView)
        self.exerciseView.addSubview(bottomView)

	}
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    func next() {
        self.performSegueWithIdentifier("two", sender: nil)
    }
}
