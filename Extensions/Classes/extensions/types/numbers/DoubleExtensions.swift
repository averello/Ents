//
//  DoubleExtensions.swift
//  Extensions
//
//  Created by Georges Boumis on 26/07/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Extensions/blob/master/LICENSE)
//

import Foundation

public extension Double {
    
    /// converts a `Double` instance to a `CGFloat` instance.
    public var asCGFloat: QuartzCore.CGFloat {
        return QuartzCore.CGFloat(self)
    }
}
