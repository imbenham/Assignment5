//
//  SecondViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit
class SecondViewController: ExerciseViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 2"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Build four blue squares, 20 points wide, one in each corner of the screen. 
        They must stay in their respective corners on device rotation. 
        
        Use Autolayout.
        
        Your view should be in self.exerciseView, not self.view
        */
        exerciseView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let topLeftSquare = UIView(frame: CGRectZero)
        let topRightSquare = UIView(frame: CGRectZero)
        let bottomLeftSquare = UIView(frame: CGRectZero)
        let bottomRightSquare = UIView(frame: CGRectZero)
        
        let squares = [topLeftSquare, topRightSquare, bottomLeftSquare, bottomRightSquare]
        for square in squares {
            square.setTranslatesAutoresizingMaskIntoConstraints(false)
            square.backgroundColor = UIColor.blueColor()
            exerciseView.addSubview(square)
        }
        
        
        let constraintMaker =  ConstraintMaker(targetView: view)
        constraintMaker.pinAllEdges(fromView: exerciseView, toContainingView:view)
        
        constraintMaker.pin(.Top, fromView: topLeftSquare, toView: self.topLayoutGuide)
        constraintMaker.pinAndSquare(.Left, fromView: topLeftSquare, toView: exerciseView, withEdgeLength: 20)
        
        constraintMaker.pin(.Top, fromView: topRightSquare, toView: self.topLayoutGuide)
        constraintMaker.pinAndSquare(.Right, fromView: topRightSquare, toView: exerciseView, withEdgeLength: 20)
        
        constraintMaker.pin(.Bottom, fromView: bottomLeftSquare, toView: self.toolbar)
        constraintMaker.pinAndSquare(.Left, fromView: bottomLeftSquare, toView: exerciseView, withEdgeLength: 20)
        
        constraintMaker.pin(.Bottom, fromView: bottomRightSquare, toView: self.toolbar)
        constraintMaker.pinAndSquare(.Right, fromView: bottomRightSquare, toView: exerciseView, withEdgeLength: 20)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    func next() {
        self.performSegueWithIdentifier("three", sender: nil)
    }
}
