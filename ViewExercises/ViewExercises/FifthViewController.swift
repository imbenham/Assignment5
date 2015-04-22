//
//  FifthViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class FifthViewController: ExerciseViewController {
    
    let expandingButton = UIButton()
    var buttonWidth: NSLayoutConstraint!
    var buttonHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 5"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Create a green button with a red border that says ‘Tap me!’ (50px by 50px), center it in the middle of the screen.
        Once tapped, the button should animate up 20 pixels and turn red, then immediately back down 20 pixels and turn back to green. It should not be clickable while animating.
        
        Use Autolayout.
        
        Your view should be in self.exerciseView, not self.view
        */
        
        self.setUpSubviews()
        
        let constraintMaker = ConstraintMaker(targetView: view)
        constraintMaker.pinAllEdges(fromView: exerciseView, toContainingView: view)
        
        buttonWidth = constraintMaker.getWidthConstraintForView(expandingButton, withConstant: 50)
        buttonHeight = constraintMaker.getHeightConstraintForView(expandingButton, withConstant: 50)
        self.view.addConstraints([buttonHeight, buttonWidth])
        constraintMaker.centerView(expandingButton, inView: exerciseView)
    }
    
    func setUpSubviews(){
        exerciseView.setTranslatesAutoresizingMaskIntoConstraints(false)
        exerciseView.addSubview(expandingButton)
        
        expandingButton.backgroundColor = UIColor.greenColor()
        expandingButton.layer.borderWidth = 2.0
        expandingButton.layer.borderColor = UIColor.redColor().CGColor
        expandingButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        expandingButton.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
    }
    
    func buttonTapped(sender:UIButton) {
        let animations: () -> () = {
            self.view.layoutIfNeeded()
            self.buttonHeight.constant += 20
            self.buttonWidth.constant += 20
            self.expandingButton.backgroundColor = UIColor.redColor()
            self.exerciseView.layoutIfNeeded()
        }
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(1.5, animations: animations){Bool -> () in
            
            let animations: () -> () = {
                self.buttonHeight.constant -= 20
                self.buttonWidth.constant -= 20
                self.expandingButton.backgroundColor = UIColor.greenColor()
                self.exerciseView.layoutIfNeeded()
            }
            UIView.animateWithDuration(1.5, animations: animations, completion: nil)
        }

    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    func next() {
        self.performSegueWithIdentifier("six", sender: nil)
    }

}
