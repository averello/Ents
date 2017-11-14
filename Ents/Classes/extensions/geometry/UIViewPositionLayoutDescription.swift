//
//  Layout.swift
//  Ents
//
//  Created by Georges Boumis on 13/11/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

fileprivate extension UIView {
    
    /// Sets the property described by the given keypath to the value of another
    /// view with the same given keypath.
    /// - parameter keyPath: the keypath
    /// - parameter other: the other view
    final fileprivate func equal<Property>(_ keyPath: ReferenceWritableKeyPath<UIView, Property>,
                                           to other: UIView) {
        self.equal(keyPath, to: other, keyPath)
    }
    
    /// Sets the property described by the given keypath to the value of another
    /// view with another given keypath.
    /// - parameter keyPath: the keypath
    /// - parameter other: the other view
    /// - parameter otherKeyPath: the other view's keypath
    final fileprivate func equal<Property>(_ keyPath: ReferenceWritableKeyPath<UIView, Property>,
                                           to other: UIView,
                                           _ otherKeyPath: KeyPath<UIView, Property>) {
        self.set(keyPath, toValue: other[keyPath: otherKeyPath])
    }
    
    /// Sets the property described by the given keypath
    /// - parameter keyPath: the keypath
    /// - parameter value: the value
    final private func set<Property>(_ keyPath: ReferenceWritableKeyPath<UIView, Property>,
                                     toValue value: Property) {
        self[keyPath: keyPath] = value
    }
}


public extension UIView {
    
    public typealias LayoutPropertyDescription = (_ view1: UIView, _ view2: UIView) -> Void
    public typealias HierarchicalLayoutPropertyDescription = LayoutPropertyDescription
    
    public static func equal<Property>(_ keyPath: ReferenceWritableKeyPath<UIView, Property>) -> LayoutPropertyDescription {
        return UIView.equal(keyPath, keyPath)
    }
    
    /// Declares the equity of two keyPaths of two views.
    ///
    /// - parameter keyPath: the key path of the first view's property
    /// - parameter otherKeyPath: the key path of the first view's property
    /// - returns: A closure that equates the properties of its two receivers
    /// described by the given paths.
    public static func equal<Property>(_ keyPath: ReferenceWritableKeyPath<UIView, Property>,
                                       _ otherKeyPath: KeyPath<UIView, Property>) -> LayoutPropertyDescription {
        return { (view1: UIView, view2: UIView) in
            view1.equal(keyPath, to: view2, otherKeyPath)
        } as LayoutPropertyDescription
    }
}
    
public extension UIView {
    // middles
    
    /// Declares the equity of the frame bottom center points.
    public static func equalFrameBottomCenters() -> LayoutPropertyDescription {
        return UIView.equal(\.frameBottomCenter)
    }
    
    /// Declares the equity of the frame top center points.
    public static func equalFrameTopCenters() -> LayoutPropertyDescription {
        return UIView.equal(\.frameTopCenter)
    }
    
    /// Declares the equity of the frame left center points.
    public static func equalFrameLeftCenters() -> LayoutPropertyDescription {
        return UIView.equal(\.frameLeftCenter)
    }
    
    /// Declares the equity of the frame right center points.
    public static func equalFrameRightCenters() -> LayoutPropertyDescription {
        return UIView.equal(\.frameRightCenter)
    }
}

public extension UIView {
    
    // hierarchical middles
    
    /// Declares the equity of the frame bottom center point with the
    /// own-coordinate bottom center point of the other.
    public static func equalBottomCenters() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameBottomCenter, \.ownBottomCenter)
    }
    
    /// Declares the equity of the frame top center point with the
    /// own-coordinate top center point of the other.
    public static func equalTopCenters() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameTopCenter, \.ownTopCenter)
    }
    
    /// Declares the equity of the frame left center point with the
    /// own-coordinate left center point of the other.
    public static func equalLeftCenters() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameLeftCenter, \.ownLeftCenter)
    }
    
    /// Declares the equity of the frame right center point with the
    /// own-coordinate right center point of the other.
    public static func equalRightCenters() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameRightCenter, \.ownRightCenter)
    }
}

public extension UIView {
    
    // corners
    
    /// Declares the equity of the frame top left points.
    public static func equalFrameTopLeft() -> LayoutPropertyDescription {
        return UIView.equal(\.frameTopLeft)
    }
    
    /// Declares the equity of the frame top right points.
    public static func equalFrameTopRight() -> LayoutPropertyDescription {
        return UIView.equal(\.frameTopRight)
    }
    
    /// Declares the equity of the frame bottom left points.
    public static func equalFrameBottomLeft() -> LayoutPropertyDescription {
        return UIView.equal(\.frameBottomLeft)
    }
    
    /// Declares the equity of the frame bottom right points.
    public static func equalFrameBottomRight() -> LayoutPropertyDescription {
        return UIView.equal(\.frameBottomRight)
    }
}

public extension UIView {
    
    // hierarchical corners
    
    /// Declares the equity of the frame top left point with the
    /// own-coordinate top left point of the other.
    public static func equalTopLeft() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameTopLeft, \.ownTopLeft)
    }
    
    /// Declares the equity of the frame top right point with the
    /// own-coordinate top right point of the other.
    public static func equalTopRight() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameTopRight, \.ownTopRight)
    }
    
    /// Declares the equity of the frame bottom left point with the
    /// own-coordinate bottom left point of the other.
    public static func equalBottomLeft() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameBottomLeft, \.ownBottomLeft)
    }
    
    /// Declares the equity of the frame bottom right point with the
    /// own-coordinate bottom right point of the other.
    public static func equalBottomRight() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameBottomRight, \.ownBottomRight)
    }
    
}

public extension UIView {
    
    // center
    
    /// Declares the equity of the center points.
    public static func equalFrameCenters() -> LayoutPropertyDescription {
        return UIView.equal(\.center)
    }
    
}

public extension UIView {
    
    /// Declares the equity of the center point with the
    /// own-coordinate center point of the other.
    public static func equalCenters() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.center, \.ownCenter)
    }
    
}

public extension UIView {
    
    // sizes
    
    /// Declares the equity of frame sizes.
    public static func equalFrameSizes() -> LayoutPropertyDescription {
        return UIView.equal(\.frameSize)
    }
    
}

public extension UIView {

    /// Declares the equity of bound sizes.
    public static func equalBoundSizes() -> LayoutPropertyDescription {
        return UIView.equal(\.boundsSize)
    }
}


public extension UIView {

    // one dimensions
    
    /// Declares the equity of the frame left edge.
    public static func equalFrameLeft() -> LayoutPropertyDescription {
        return UIView.equal(\.frameLeft)
    }
    
    /// Declares the equity of the frame right edge.
    public static func equalFrameRight() -> LayoutPropertyDescription {
        return UIView.equal(\.frameRight)
    }
    
    /// Declares the equity of the frame top edge.
    public static func equalFrameTop() -> LayoutPropertyDescription {
        return UIView.equal(\.frameTop)
    }
    
    /// Declares the equity of the frame bottom edge.
    public static func equalFrameBottom() -> LayoutPropertyDescription {
        return UIView.equal(\.frameBottom)
    }
    
    /// Declares the equity of the center x.
    public static func equalFrameCenterX() -> LayoutPropertyDescription {
        return UIView.equal(\.centerX)
    }

    /// Declares the equity of the center y.
    public static func equalFrameCenterY() -> LayoutPropertyDescription {
        return UIView.equal(\.centerX)
    }
}

public extension UIView {
    
    // one dimensions
    
    /// Declares the equity of the frame width.
    public static func equalFrameWidth() -> LayoutPropertyDescription {
        return UIView.equal(\.frameWidth)
    }
    
    /// Declares the equity of the frame height.
    public static func equalFrameHeight() -> LayoutPropertyDescription {
        return UIView.equal(\.frameHeight)
    }
    
    /// Declares the equity of the bounds width.
    public static func equalBoundsWidth() -> LayoutPropertyDescription {
        return UIView.equal(\.boundsWidth)
    }
    
    /// Declares the equity of the bounds height.
    public static func equalBoundsHeight() -> LayoutPropertyDescription {
        return UIView.equal(\.boundsHeight)
    }
}


public extension UIView {
    
    // hierarchical one dimensions
    
    /// Declares the equity of the left edge with the
    /// own-coordinate left edge of the other.
    public static func equalLeft() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameLeft, \.ownLeft)
    }
    
    /// Declares the equity of the right edge with the
    /// own-coordinate right edge of the other.
    public static func equalRight() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameRight, \.ownRight)
    }
    
    /// Declares the equity of the top edge with the
    /// own-coordinate top edge of the other.
    public static func equalTop() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameTop, \.ownTop)
    }
    
    /// Declares the equity of the bottom edge with the
    /// own-coordinate bottom edge of the other.
    public static func equalBottom() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameBottom, \.ownBottom)
    }
    
    /// Declares the equity of the center x with the
    /// own-coordinate center x of the other.
    public static func equalCenterX() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.centerX, \.ownCenterX)
    }
    
    /// Declares the equity of the center y with the
    /// own-coordinate center y of the other.
    public static func equalCenterY() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.centerY, \.ownCenterY)
    }
}

public extension UIView {
    
    // hierarchical one dimensions
    
    /// Declares the equity of the frame width with the
    /// own-coordinate bounds width of the other.
    public static func equalWidth() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameWidth, \.boundsWidth)
    }
    
    /// Declares the equity of the frame height with the
    /// own-coordinate bounds height of the other.
    public static func equalHeight() -> HierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameHeight, \.boundsHeight)
    }
}
