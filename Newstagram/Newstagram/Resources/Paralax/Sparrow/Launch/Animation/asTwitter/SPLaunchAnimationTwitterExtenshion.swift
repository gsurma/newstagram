//
//  SPLaunchAnimationTwitterExtenshion.swift
//  TwitterLaunchAnimation
//
//  Created by Ivan Vorobei on 10/10/16.
//  Copyright © 2016 Ivan Vorobei. All rights reserved.
//

import UIKit

extension SPLaunchAnimation {
    
    //logo side size. Set equal in TwitterLaunchScreen constraint
    static private let logoSideSize: CGFloat = 68
    //scale logo in middle animation
    static private let scaleLogoFactor: CGFloat = 0.9
    //y position logo. Set equal in TwitterLaunchScreen constraint
    static private let yPositinTranslationOnStartScreen: CGFloat = 0.91
    //scale root view controller from
    static private let scaleFactorRootView: CGFloat = 1.09
    //duration all animation
    static private let duration: TimeInterval = 0.7
    //position change animation in timeline: [0..1]
    static private let changeAnimationFactor: NSNumber = 0.52
    //background color. Set equal in TwitterLaunchScreen constraint
    static private let backgroundColor = UIColor.init(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
    //in end animation scale mask
    static private let scaleMaskInEndFactor: CGFloat = 3.3
    //delay for start animation
    static private let delay: Double = 1
    //options animations grade view and root view
    static private let delayHidyingGradeView: TimeInterval = 1.4
    static private let durationHidyingGradeView: TimeInterval = 0.095
    static private let delayScalingRootView: TimeInterval = 1.4
    static private let durationScalingRootView: TimeInterval = 0.45
    //timing function for scale twitter to front
    static private let scalingToFrontTimingFunction = CAMediaTimingFunction.init(controlPoints: 1, 0, 0, 1)
    
    static func asTwitter(icon iconImage: UIImage, onWindow window: UIWindow) {
        
        window.backgroundColor = backgroundColor
        window.makeKeyAndVisible()
        
        let rootViewController = window.rootViewController!
        
        let gradeView = UIView.init(frame: rootViewController.view.frame)
        gradeView.backgroundColor = UIColor.white
        rootViewController.view.addSubview(gradeView)
        
        rootViewController.view.transform = CGAffineTransform(
            scaleX: scaleFactorRootView,
            y: scaleFactorRootView
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.contents = iconImage.cgImage
        
        var logoSideSize = self.logoSideSize
        logoSideSize = logoSideSize * yPositinTranslationOnStartScreen
        maskLayer.bounds = CGRect.init(
            x: 0,
            y: 0,
            width: logoSideSize,
            height: logoSideSize
        )
        maskLayer.position = CGPoint.init(
            x: rootViewController.view.center.x,
            y: rootViewController.view.center.y / scaleFactorRootView
        )
        
        rootViewController.view.layer.addSublayer(maskLayer)
        rootViewController.view.layer.mask = maskLayer
        
        let initialScale = NSValue(caTransform3D:
            CATransform3DScale(rootViewController.view.layer.mask!.transform, 1, 1, 1)
        )
        
        let secondScale = NSValue(caTransform3D:
            CATransform3DScale(rootViewController.view.layer.mask!.transform, self.scaleLogoFactor, self.scaleLogoFactor, 1)
        )
        
        let scale = UIScreen.main.bounds.height / (rootViewController.view.layer.mask!.bounds.height / 3) * scaleMaskInEndFactor
        let finalScale = NSValue(caTransform3D:
            CATransform3DScale(
                rootViewController.view.layer.mask!.transform, scale, scale, 1)
        )
        
        let scaleAnimation = CAKeyframeAnimation.init(keyPath: "transform.scale")
        scaleAnimation.values = [initialScale, secondScale, finalScale]
        scaleAnimation.keyTimes = [0, changeAnimationFactor, 1]
        scaleAnimation.duration = duration
        let startTime = CACurrentMediaTime() + delay
        scaleAnimation.beginTime = startTime
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
            self.scalingToFrontTimingFunction
        ]
        rootViewController.view.layer.mask?.add(scaleAnimation, forKey: "maskScaleAnimation")
        
        SPAnimation.animate(self.durationHidyingGradeView,
                            animations: {
                                gradeView.alpha = 0
            },
                            delay: self.delayHidyingGradeView,
                            options: UIViewAnimationOptions.curveEaseInOut,
                            withComplection: {
                                gradeView.removeFromSuperview()
        })
        
        SPAnimation.animate(durationScalingRootView,
                            animations: {
                                rootViewController.view.transform = CGAffineTransform.identity
            },
                            delay: delayScalingRootView,
                            options: UIViewAnimationOptions.curveEaseOut,
                            withComplection: {
                                //rootViewController.view.layer.mask = nil
        })
        
    }
    
    static func asTwitter(icon iconBezierPath: UIBezierPath, onWindow window: UIWindow) {
        
        window.backgroundColor = backgroundColor
        window.makeKeyAndVisible()
        
        let rootViewController = window.rootViewController!
        
        let gradeView = UIView.init(frame: rootViewController.view.frame)
        gradeView.backgroundColor = UIColor.white
        rootViewController.view.addSubview(gradeView)
        
        rootViewController.view.transform = CGAffineTransform(
            scaleX: scaleFactorRootView,
            y: scaleFactorRootView
        )
        
        var logoSideSize = self.logoSideSize
        logoSideSize = logoSideSize / scaleFactorRootView
        let logoScaleFactor = logoSideSize / iconBezierPath.bounds.width
        let logoScaleTransform = CGAffineTransform.init(
            scaleX: logoScaleFactor,
            y: logoScaleFactor
        )
        iconBezierPath.apply(logoScaleTransform)
        
        let logoTranslationY = (logoSideSize - iconBezierPath.bounds.height) / 2
        let logoTranslationYTransform = CGAffineTransform.init(
            translationX: 0,
            y: logoTranslationY
        )
        iconBezierPath.apply(logoTranslationYTransform)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect.init(x: 0, y: 0, width: logoSideSize, height: logoSideSize)
        maskLayer.path = iconBezierPath.cgPath
        maskLayer.fillColor = UIColor.blue.cgColor
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.frame.origin = CGPoint.init(
            x: (window.bounds.width / 2) - (maskLayer.bounds.width / 2),
            y: ((window.bounds.height / 2) - (maskLayer.bounds.height / 2)) * yPositinTranslationOnStartScreen
        )
        
        rootViewController.view.layer.addSublayer(maskLayer)
        rootViewController.view.layer.mask = maskLayer
        
        let initialScale = NSValue(caTransform3D:
            CATransform3DScale(rootViewController.view.layer.mask!.transform, 1, 1, 1)
        )
        
        let secondScale = NSValue(caTransform3D:
            CATransform3DScale(rootViewController.view.layer.mask!.transform, self.scaleLogoFactor, self.scaleLogoFactor, 1)
        )
        
        let scale = UIScreen.main.bounds.height / (rootViewController.view.layer.mask!.bounds.height / 3) * scaleMaskInEndFactor
        let finalScale = NSValue(caTransform3D:
            CATransform3DScale(
                rootViewController.view.layer.mask!.transform, scale, scale, 1)
        )
        
        let scaleAnimation = CAKeyframeAnimation.init(keyPath: "transform.scale")
        scaleAnimation.values = [initialScale, secondScale, finalScale]
        scaleAnimation.keyTimes = [0, changeAnimationFactor, 1]
        scaleAnimation.duration = duration
        let startTime = CACurrentMediaTime() + delay
        scaleAnimation.beginTime = startTime
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
            self.scalingToFrontTimingFunction
        ]
        rootViewController.view.layer.mask?.add(scaleAnimation, forKey: "maskScaleAnimation")
        
        SPAnimation.animate(durationHidyingGradeView,
                            animations: {
                                gradeView.alpha = 0
            },
                            delay: delayHidyingGradeView,
                            options: UIViewAnimationOptions.curveEaseInOut,
                            withComplection: {
                                gradeView.removeFromSuperview()
        })
        
        SPAnimation.animate(durationScalingRootView,
                            animations: {
                                rootViewController.view.transform = CGAffineTransform.identity
            },
                            delay: delayScalingRootView,
                            options: UIViewAnimationOptions.curveEaseOut,
                            withComplection: {
                                //rootViewController.view.layer.mask = nil
        })
    }
}
