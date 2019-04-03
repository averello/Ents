//
//  UIViewExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 29/08/2016.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
#if canImport(CoreGraphics) && canImport(UIKit)
import UIKit
import CoreGraphics

public extension UIView {
    
    /// the view layer's anchor point.
    final var layerAnchorPoint: CGPoint {
        get {
            return self.layer.anchorPoint
        }
        set {
            self.layer.setAnchorPointWithoutMoving(newValue)
        }
    }
}

public extension UIView {
    
    /// scales the receiver's frame with the provided scale.
    /// - parameter scale: a factor.
    final func scale(_ scale: CGFloat) {
        self.frameSize.scale(scale)
    }
}

public extension UIView {
    
    /// sets the center of the view using a specific anchor point.
    /// - parameter point: the anchor point to use.
    /// - parameter block: a closure that returns the new center of the receiver.
    final func center<V>(withAnchorPoint point: CGPoint, _ block: (V) -> CGPoint) where V: UIView {
        let anchorPoint = self.layer.anchorPoint
        self.layerAnchorPoint = point
        self.center = block(self as! V)
        self.layerAnchorPoint = anchorPoint
    }
    
    /// Evaluates the given closure with no transform applied to the receiver,
    /// passing the receiver as its argument.
    /// - parameter block: a closure to evaluate without transformations.
    final func withoutTransform<V>(_ block: (V) -> Void) where V: UIView {
        let transform = self.transform
        self.transform = CGAffineTransform.identity
        block(self as! V)
        self.transform = transform
    }
}

#endif
