//
//  FourthViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

extension ExerciseViewController: UIScrollViewDelegate {

    
}

class FourthViewController: ExerciseViewController {
    
    let scrollView = UIScrollView()
    let topBanner = UIView()
    let bottomBanner = UIView()
    let purpleLabel =  UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 4"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Build a scroll view that takes up the entire screen. 
        
        In the scroll view, place a blue box at the top (20px high, 10px horizontal margins with the screen, a very tall (1000+px, width the same as the screen) purple label containing white text in the middle, and a red box at the bottom (20px high, 10px horizontal margins with the screen). The scroll view should scroll the entire height of the content.
        
        Use Autolayout.

        
        Your view should be in self.exerciseView, not self.view.
        */
        

        
    }
    
    override func viewWillAppear(animated: Bool) {
    
    }
    
    override func viewDidLayoutSubviews() {
        self.setUpSubviews()
        let constraintMaker =  ConstraintMaker(targetView: view)
        constraintMaker.pinAllEdges(fromView: exerciseView, toContainingView: view, withOffset:0)
        constraintMaker.pinAllEdges(fromView: scrollView, toContainingView:exerciseView)
        
        constraintMaker.targetView = scrollView
        constraintMaker.pinEdges([.Left, .Right], fromView: topBanner, toViews: [scrollView, scrollView], withConstant: 10)
        constraintMaker.pinWithConstant(0, view: topBanner, toView: scrollView, forEdge: .Top)
        constraintMaker.constrainHeightOfView(topBanner, withConstant: 20)
        
        
        constraintMaker.pinEdges([.Top, .Left, .Right], fromView: purpleLabel, toViews: [topBanner,scrollView, scrollView])
        constraintMaker.constrainSizeOfView(purpleLabel, toView: scrollView, withWidthMultiplier: 1, andHeightMultiplier: nil)
        constraintMaker.constrainHeightOfView(purpleLabel, withConstant: 1200)
        
        constraintMaker.pinEdges([.Left, .Right], fromView: bottomBanner, toViews: [scrollView, scrollView], withConstant: 10)
        constraintMaker.pin(.Top, fromView: bottomBanner, toView: purpleLabel)
        constraintMaker.constrainHeightOfView(bottomBanner, withConstant: 20)

    }
    
    func setUpSubviews() {
        exerciseView.setTranslatesAutoresizingMaskIntoConstraints(false)
        exerciseView.addSubview(scrollView)
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(topBanner)
        topBanner.setTranslatesAutoresizingMaskIntoConstraints(false)
        topBanner.backgroundColor = UIColor.blueColor()
        scrollView.addSubview(bottomBanner)
        bottomBanner.setTranslatesAutoresizingMaskIntoConstraints(false)
        bottomBanner.backgroundColor = UIColor.redColor()
        scrollView.addSubview(purpleLabel)
        purpleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        purpleLabel.backgroundColor = UIColor.purpleColor()
        purpleLabel.textColor = UIColor.whiteColor()
        purpleLabel.text = "I'm a big purple label!"
        purpleLabel.textAlignment = .Center
        
        scrollView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 2000)
        scrollView.delegate = self
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    func next() {
        self.performSegueWithIdentifier("five", sender: nil)
    }

}
