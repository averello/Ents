//
//  Layout.swift
//  Ents
//
//  Created by Georges Boumis on 13/11/2017.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

#if canImport(UIKit)
import UIKit
import CoreGraphics

fileprivate extension UIView {
    
    /// Sets the property described by the given keypath to the value of another
    /// view with the same given keypath.
    /// - parameter keyPath: the keypath
    /// - parameter other: the other view
    final func equal<Property, V>(_ keyPath: ReferenceWritableKeyPath<V, Property>,
                                              to other: V) where V: UIView {
        self.equal(keyPath, to: other, keyPath)
    }
    
    /// Sets the property described by the given keypath to the value of another
    /// view with another given keypath.
    /// - parameter keyPath: the keypath
    /// - parameter other: the other view
    /// - parameter otherKeyPath: the other view's keypath
    final func equal<Property, V>(_ keyPath: ReferenceWritableKeyPath<V, Property>,
                                              to other: V,
                                              _ otherKeyPath: KeyPath<V, Property>) where V: UIView {
        self.set(keyPath, toValue: other[keyPath: otherKeyPath])
    }
    
    /// Sets the property described by the given keypath
    /// - parameter keyPath: the keypath
    /// - parameter value: the value
    final private func set<Property, V>(_ keyPath: ReferenceWritableKeyPath<V, Property>,
                                        toValue value: Property) where V: UIView {
        self._set(keyPath as! ReferenceWritableKeyPath<UIView, Property>, toValue: value)
    }
    
    /// Sets the property described by the given keypath to the concrete type UIView
    /// - parameter keyPath: the keypath
    /// - parameter value: the value
    final private func _set<Property>(_ keyPath: ReferenceWritableKeyPath<UIView, Property>,
                                      toValue value: Property) {
        self[keyPath: keyPath] = value
    }
}

public extension UIView {
    
    typealias LayoutPropertyDescription<A,B> = (_ view1: A, _ view2: B) -> Void where A: UIView, B: UIView
    typealias HierarchicalLayoutPropertyDescription<A,B> = LayoutPropertyDescription<A,B> where A: UIView, B: UIView
    typealias LayoutPropertyConverter<Property, A, B> = (_ property: Property, _ view1: A, _ view2: B) -> Property where A: UIView, B: UIView
    
    
    /// Declares the equity of the same keyPaths of two views.
    ///
    /// - parameter keyPath: the key path of the views' property
    /// - returns: A closure that equates the properties of its two receivers
    /// described by the given path.
    static func equal<Property, V>(_ keyPath: ReferenceWritableKeyPath<V, Property>) -> LayoutPropertyDescription<V, V> where V: UIView {
        return V.equal(keyPath, keyPath)
    }
    
//    /// Declares the equity of two keyPaths of two views.
//    ///
//    /// - parameter keyPath: the key path of the first view's property
//    /// - parameter otherKeyPath: the key path of the first view's property
//    /// - returns: A closure that equates the properties of its two receivers
//    /// described by the given paths.
//    public static func equal<Property, V>(_ keyPath: ReferenceWritableKeyPath<V, Property>,
//                                          _ otherKeyPath: KeyPath<V, Property>) -> LayoutPropertyDescription<V,V> where V: UIView {
//        return { (view1: V, view2: V) in
//            view1.equal(keyPath, to: view2, otherKeyPath)
//            } as LayoutPropertyDescription<V, V>
//    }
    
    /// Declares the equity of two keyPaths of two views.
    ///
    /// - parameter keyPath: the key path of the first view's property
    /// - parameter otherKeyPath: the key path of the first view's property
    /// - parameter converter: a transformation closure
    /// - returns: A closure that equates the properties of its two receivers
    /// described by the given paths.
    static func equal<Property, V>(_ keyPath: ReferenceWritableKeyPath<V, Property>,
                                          _ otherKeyPath: KeyPath<V, Property>,
                                          converter: @escaping LayoutPropertyConverter<Property, V, V> = { value,_,_ in return value } ) -> LayoutPropertyDescription<V, V> where V: UIView {
        return { (view1: V, view2: V) in
            let v2 = view2[keyPath: otherKeyPath]
            view1[keyPath: keyPath] = converter(v2, view1, view2)
            } as LayoutPropertyDescription<V, V>
    }

    /// Combines/Chains two `LayoutPropertyConverter` together.
    ///
    /// - parameter a: a property converter
    /// - parameter b: another property converter
    /// - returns: A property converter that uses the result of `a` as the input
    /// of `b` to provide combined/chained final result.
    static func combine<Property, A, B>(_ a: @escaping LayoutPropertyConverter<Property, A, B>,
                                               _ b: @escaping LayoutPropertyConverter<Property, A, B>)
        -> LayoutPropertyConverter<Property, A, B>
    {
        return { (property: Property, view1: A, view2: B) in
            return b(a(property, view1, view2), view1, view2)
        }
    }
}

public extension UIView {
    
    typealias AnyLayoutPropertyDescription = LayoutPropertyDescription<UIView, UIView>
    typealias AnyHierarchicalLayoutPropertyDescription = AnyLayoutPropertyDescription
    typealias AnyLayoutPropertyConverter<Property> = LayoutPropertyConverter<Property, UIView, UIView>
}

public extension UIView {
    // middles
    
    /// Declares the equity of the frame bottom center points.
    static var equalFrameBottomCenters: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameBottomCenter)
    }
    
    /// Declares the equity of the frame top center points.
    static var equalFrameTopCenters: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameTopCenter)
    }
    
    /// Declares the equity of the frame left center points.
    static var equalFrameLeftCenters: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameLeftCenter)
    }
    
    /// Declares the equity of the frame right center points.
    static var equalFrameRightCenters: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameRightCenter)
    }
}

public extension UIView {
    
    // hierarchical middles
    
    /// Declares the equity of the frame bottom center point with the
    /// own-coordinate bottom center point of the other.
    static var equalBottomCenters: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameBottomCenter, \.ownBottomCenter)
    }
    
    /// Declares the equity of the frame top center point with the
    /// own-coordinate top center point of the other.
    static var equalTopCenters: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameTopCenter, \.ownTopCenter)
    }
    
    /// Declares the equity of the frame left center point with the
    /// own-coordinate left center point of the other.
    static var equalLeftCenters: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameLeftCenter, \.ownLeftCenter)
    }
    
    /// Declares the equity of the frame right center point with the
    /// own-coordinate right center point of the other.
    static var equalRightCenters: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameRightCenter, \.ownRightCenter)
    }
}

public extension UIView {
    
    // corners
    
    /// Declares the equity of the frame top left points.
    static var equalFrameTopLeft: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameTopLeft)
    }
    
    /// Declares the equity of the frame top right points.
    static var equalFrameTopRight: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameTopRight)
    }
    
    /// Declares the equity of the frame bottom left points.
    static var equalFrameBottomLeft: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameBottomLeft)
    }
    
    /// Declares the equity of the frame bottom right points.
    static var equalFrameBottomRight: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameBottomRight)
    }
}

public extension UIView {
    
    // hierarchical corners
    
    /// Declares the equity of the frame top left point with the
    /// own-coordinate top left point of the other.
    static var equalTopLeft: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameTopLeft, \.ownTopLeft)
    }
    
    /// Declares the equity of the frame top right point with the
    /// own-coordinate top right point of the other.
    static var equalTopRight: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameTopRight, \.ownTopRight)
    }
    
    /// Declares the equity of the frame bottom left point with the
    /// own-coordinate bottom left point of the other.
    static var equalBottomLeft: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameBottomLeft, \.ownBottomLeft)
    }
    
    /// Declares the equity of the frame bottom right point with the
    /// own-coordinate bottom right point of the other.
    static var equalBottomRight: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameBottomRight, \.ownBottomRight)
    }
}

public extension UIView {
    
    // center
    
    /// Declares the equity of the center points.
    static var equalFrameCenters: AnyLayoutPropertyDescription {
        return UIView.equal(\.center)
    }
    
}

public extension UIView {
    
    /// Declares the equity of the center point with the
    /// own-coordinate center point of the other.
    static var equalCenters: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.center, \.ownCenter)
    }
}

public extension UIView {
    
    // sizes
    
    /// Declares the equity of frame sizes.
    static var equalFrameSizes: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameSize)
    }
}

public extension UIView {
    
    /// Declares the equity of bound sizes.
    static var equalBoundSizes: AnyLayoutPropertyDescription {
        return UIView.equal(\.boundsSize)
    }
}


public extension UIView {
    
    // one dimensions
    
    /// Declares the equity of the frame left edge.
    static var equalFrameLeft: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameLeft)
    }
    
    /// Declares the equity of the frame right edge.
    static var equalFrameRight: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameRight)
    }
    
    /// Declares the equity of the frame top edge.
    static var equalFrameTop: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameTop)
    }
    
    /// Declares the equity of the frame bottom edge.
    static var equalFrameBottom: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameBottom)
    }
    
    /// Declares the equity of the center x.
    static var equalFrameCenterX: AnyLayoutPropertyDescription {
        return UIView.equal(\.centerX)
    }
    
    /// Declares the equity of the center y.
    static var equalFrameCenterY: AnyLayoutPropertyDescription {
        return UIView.equal(\.centerX)
    }
}

public extension UIView {
    
    // one dimensions
    
    /// Declares the equity of the frame width.
    static var equalFrameWidth: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameWidth)
    }
    
    /// Declares the equity of the frame height.
    static var equalFrameHeight: AnyLayoutPropertyDescription {
        return UIView.equal(\.frameHeight)
    }
    
    /// Declares the equity of the bounds width.
    static var equalBoundsWidth: AnyLayoutPropertyDescription {
        return UIView.equal(\.boundsWidth)
    }
    
    /// Declares the equity of the bounds height.
    static var equalBoundsHeight: AnyLayoutPropertyDescription {
        return UIView.equal(\.boundsHeight)
    }
}


public extension UIView {
    
    // hierarchical one dimensions
    
    /// Declares the equity of the left edge with the
    /// own-coordinate left edge of the other.
    static var equalLeft: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameLeft, \.ownLeft)
    }
    
    /// Declares the equity of the right edge with the
    /// own-coordinate right edge of the other.
    static var equalRight: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameRight, \.ownRight)
    }
    
    /// Declares the equity of the top edge with the
    /// own-coordinate top edge of the other.
    static var equalTop: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameTop, \.ownTop)
    }
    
    /// Declares the equity of the bottom edge with the
    /// own-coordinate bottom edge of the other.
    static var equalBottom: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameBottom, \.ownBottom)
    }
    
    /// Declares the equity of the center x with the
    /// own-coordinate center x of the other.
    static var equalCenterX: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.centerX, \.ownCenterX)
    }
    
    /// Declares the equity of the center y with the
    /// own-coordinate center y of the other.
    static var equalCenterY: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.centerY, \.ownCenterY)
    }
}

public extension UIView {
    
    // hierarchical one dimensions
    
    /// Declares the equity of the frame width with the
    /// own-coordinate bounds width of the other.
    static var equalWidth: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameWidth, \.boundsWidth)
    }
    
    /// Declares the equity of the frame height with the
    /// own-coordinate bounds height of the other.
    static var equalHeight: AnyHierarchicalLayoutPropertyDescription {
        return UIView.equal(\.frameHeight, \.boundsHeight)
    }
}

#endif
