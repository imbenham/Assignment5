//
//  ViewPinner.swift
//  ViewExercises
//
//  Created by Isaac Benham on 4/19/15.
//  Copyright (c) 2015 Rudd Taylor. All rights reserved.
//

import UIKit

extension UIView: UILayoutSupport {
    public var length:CGFloat {
        get {
            return self.frame.size.height
        }
    }
}
class ConstraintMaker {
    
    var targetView: UIView
    var pinConstant: CGFloat = 0
    
    init (targetView tv: UIView){
        targetView = tv
    }
    
    func pinEdges<T:UILayoutSupport>(edges: [EdgeAttributeType], fromView view: UIView, toViews views:[T], withConstant constant: CGFloat = 0){
        if edges.count != views.count {
            return
        }
        var index = 0
        
        for edge in edges {
            self.pinWithConstant(constant, view: view, toView: views[index], forEdge: edge)
            index++
        }
    }
    
    func pinTwoEdgesAndSquare<T:UILayoutSupport>(attribs:[EdgeAttributeType], fromView view1:UIView, toView view2:T, withEdgeLength edgeLength:CGFloat) {
        var constraints = [NSLayoutConstraint]()
        
        for attrib in attribs {
            constraints.append(attrib.pinViewToEdge(view1, toView: view2))
        }
        
        constraints += self.makeSquareConstraintsWithSize(edgeLength, forView: view1)
        
        targetView.addConstraints(constraints)
    }
    
    func pinAndSquare<T:UILayoutSupport>(attrib:EdgeAttributeType, fromView view1:UIView, toView view2:T, withEdgeLength edgeLength:CGFloat){
        var constraints = [attrib.pinViewToEdge(view1, toView: view2)]
       
        constraints += self.makeSquareConstraintsWithSize(edgeLength, forView: view1)
        
        targetView.addConstraints(constraints)
    }
    
    func pin<T:UILayoutSupport>(attrib:EdgeAttributeType, fromView view1:UIView, toView view2:T) {
        var constraint = attrib.pinViewToEdge(view1, toView: view2)
       
        constraint.constant += (constraint.firstAttribute == NSLayoutAttribute.Trailing || constraint.firstAttribute == NSLayoutAttribute.Bottom) ? pinConstant * -2 : pinConstant
        targetView.addConstraint(constraint)
        pinConstant = 0
    }
    
    func pinWithConstant<T:UILayoutSupport>(constant: CGFloat, view view1:UIView, toView view2: T, forEdge edge: EdgeAttributeType){
        pinConstant = constant
        self.pin(edge, fromView: view1, toView: view2)
    }
    
    
    // pins all edges the same distance from parent view edges; doesn't account for top/bottom layout guides
    func pinAllEdges<T:UILayoutSupport>(fromView view1:UIView, toContainingView view2:T, withOffset offset: CGFloat) {
        let attribs:[EdgeAttributeType] = [.Top, .Bottom, .Left, .Right]
    
        for attrib in attribs {
            pinConstant = offset
            self.pin(attrib, fromView: view1, toView: view2)
            pinConstant = 0
        }
    }
    
    func pinAllEdges<T:UILayoutSupport>(fromView view1: UIView, toContainingView view2:T){
        self.pinAllEdges(fromView: view1, toContainingView: view2, withOffset: 0)
    }
    
    func constrainSizeOfView(view: UIView, withWidth width: CGFloat?, andHeight height: CGFloat?) {
        
        if width != nil {
            targetView.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: width!))
        }
        
        if height != nil {
            targetView.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: height!))
            println("height constrained!")
        }
    }
    
    func constrainSizeOfView(view1: UIView, toView view2: UIView, withWidthMultiplier widthMultiplier: CGFloat?, andHeightMultiplier heightMultiplier: CGFloat?) {
        if widthMultiplier != nil {
            targetView.addConstraint(NSLayoutConstraint(item: view1, attribute: .Width, relatedBy: .Equal, toItem: view2, attribute: .Width, multiplier: 1, constant: 0))
        }
        
        if heightMultiplier != nil {
            targetView.addConstraint(NSLayoutConstraint(item: view1, attribute: .Height, relatedBy: .Equal, toItem: view2, attribute: .Height, multiplier: 1, constant: 0))
        }
    }
    
    func constrainWidthOfView(view: UIView, withConstant constant: CGFloat) {
        self.constrainSizeOfView(view, withWidth: constant, andHeight: nil)
    }
    
    func constrainHeightOfView(view: UIView, withConstant constant: CGFloat){
        self.constrainSizeOfView(view, withWidth: nil, andHeight: constant)
    }
    
    func getWidthConstraintForView(view: UIView, withConstant constant: CGFloat) -> NSLayoutConstraint {
        let wC = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant)
        return wC
    }
    func getHeightConstraintForView(view: UIView, withConstant constant: CGFloat) -> NSLayoutConstraint {
        let hC = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant)
        return hC

    }

    private func makeSquareConstraintsWithSize(size: CGFloat, forView view:UIView) -> [NSLayoutConstraint]{
        
        let constraint1 = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: size)
        let constraint2 = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
        
        return [constraint1, constraint2]
    }
    
    // MARK: alignment functions 
    func centerXConstraint(forView view1: UIView, againstView view2:UIView, withOffset offset:CGFloat = 0) {
        let constraint = NSLayoutConstraint(item: view1, attribute: .CenterX, relatedBy: .Equal, toItem: view2, attribute: .CenterX, multiplier: 1, constant: offset)
        targetView.addConstraint(constraint)
    }
    func centerYConstraint(forView view1: UIView, againstView view2:UIView, withOffset offset:CGFloat = 0) {
        let constraint = NSLayoutConstraint(item: view1, attribute: .CenterY, relatedBy: .Equal, toItem: view2, attribute: .CenterY, multiplier: 1, constant: offset)
        targetView.addConstraint(constraint)
    }
    func centerView(view1:UIView, inView view2:UIView) {
        self.centerXConstraint(forView: view1, againstView: view2)
        self.centerYConstraint(forView: view1, againstView: view2)
    }

}

enum EdgeAttributeType {
    case Top, Bottom, Left, Right
    
    func getAttributes<T:UILayoutSupport>(view1:UIView, view2:T)->(firstAttribute:NSLayoutAttribute, secondAttribute:NSLayoutAttribute) {
        switch self {
        case .Top:
            let attribute2:NSLayoutAttribute = self.isASubview(view1, ofview: view2) ? .Top : .Bottom
            return (.Top, attribute2)
        case .Bottom:
            let attribute2:NSLayoutAttribute = self.isASubview(view1, ofview: view2) ? .Bottom : .Top
            return (.Bottom, attribute2)
        case .Left:
            let attribute2:NSLayoutAttribute = self.isASubview(view1, ofview: view2) ? .Leading : .Trailing
            return (.Leading, attribute2)
        case .Right:
            let attribute2:NSLayoutAttribute = self.isASubview(view1, ofview: view2) ? .Trailing : .Leading
            return (.Trailing, attribute2)
        }
    }
    
    func isASubview<T:UILayoutSupport>(view1:UIView, ofview view2:T)->Bool {
        if let viewPerhaps = view2 as? UIView {
            return !viewPerhaps.subviews.filter({$0===view1}).isEmpty
        }
        println("not a view")
        return false
    }
    
    func pinViewToEdge<T:UILayoutSupport>(view1: UIView, toView view2:T)->NSLayoutConstraint{
        let constraint = NSLayoutConstraint(item: view1, attribute: self.getAttributes(view1, view2:view2).0, relatedBy: .Equal, toItem: view2, attribute: self.getAttributes(view1, view2:view2).1, multiplier: 1, constant: 0)
        
        let attributes = self.getAttributes(view1,view2: view2)
        
        return constraint
    }
    
}


