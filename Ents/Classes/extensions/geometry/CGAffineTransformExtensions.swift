//
//  CGAffineTransformExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 29/08/2016.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
#if canImport(CoreGraphics) && canImport(QuartzCore)
import CoreGraphics
import QuartzCore

extension CGAffineTransform {
    
    /// creates a `CATransform3D` instance from this `CGAffineTransform` instance.
    public var asCATransform3D: CATransform3D {
        return CATransform3DMakeAffineTransform(self)
    }
    
    /// creates a `NSValue` instance from this `CGAffineTransform` instance.
    public var value: NSValue {
        return NSValue(cgAffineTransform: self)
    }

    /// concatenate this instance of `CGAffineTransform` with another instance of `CGAffineTransform`.
    public mutating func concatenate(_ t: CGAffineTransform) {
        self = self.concatenating(t)
    }
}

#endif
