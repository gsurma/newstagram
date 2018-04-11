//
//  Delay.swift
//  reincarnation
//
//  Created by Ivan Vorobei on 6/24/16.
//  Copyright © 2016 Ivan Vorobei. All rights reserved.
//

import Foundation

public func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when) {
        closure()
    }
}
