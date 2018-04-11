//
//  Constraints.swift
//  reincarnation
//
//  Created by Ivan Vorobei on 6/19/16.
//  Copyright © 2016 Ivan Vorobei. All rights reserved.
//

import UIKit

struct SPConstraintsAssistent {
    
    static func setEqualSizeConstraint(_ subView: UIView, superVuew: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false;
        let topMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.topMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: 0)
        
        let bottomMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.bottomMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: 0)
        
        let leadingMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.leadingMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.leading,
            multiplier: 1,
            constant: 0)
        
        let trailingMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.trailingMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.trailing,
            multiplier: 1,
            constant: 0)
        
        superVuew.addConstraints([
            topMarginConstraint, bottomMarginConstraint, leadingMarginConstraint, trailingMarginConstraint
            ])
    }
    
    static func setMarginConstraint(_ subView: UIView, superVuew: UIView, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false;

        let bottomMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.bottomMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: -bottom)
        
        let leadingMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.leadingMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.leading,
            multiplier: 1,
            constant: leading)
        
        let trailingMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.trailingMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.trailing,
            multiplier: 1,
            constant: -trailing)
        
        superVuew.addConstraints([bottomMarginConstraint, leadingMarginConstraint, trailingMarginConstraint
            ])
    }
    
    static func setMarginConstraint(_ subView: UIView, superVuew: UIView, top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false;
        let topMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.topMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: top)
        
        let bottomMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.bottomMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: -bottom)
        
        let leadingMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.leadingMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.leading,
            multiplier: 1,
            constant: leading)
        
        let trailingMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutAttribute.trailingMargin,
            relatedBy: NSLayoutRelation.equal,
            toItem: superVuew,
            attribute: NSLayoutAttribute.trailing,
            multiplier: 1,
            constant: -trailing)
        
        superVuew.addConstraints([
            topMarginConstraint, bottomMarginConstraint, leadingMarginConstraint, trailingMarginConstraint
            ])
    }
    
    static func setCenteringConstraint(_ subView: UIView, superView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false;
        
        let centerXConstraint = NSLayoutConstraint(
            item: subView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: superView,
            attribute: .centerX,
            multiplier: 1, constant: 0
        )
        
        let centerYConstraint = NSLayoutConstraint(
            item: subView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: superView,
            attribute: .centerY,
            multiplier: 1, constant: 0
        )
        
        superView.addConstraints([
            centerXConstraint, centerYConstraint
            ])
    }
}


       
