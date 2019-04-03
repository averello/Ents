//
//  UIOffsetExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 13/04/2018.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
#if canImport(CoreGraphics) && canImport(UIKit)
import UIKit

public extension UIOffset {
    
    var negated: UIOffset {
        var o = self
        o.horizontal = self.horizontal.negated()
        o.vertical = self.vertical.negated()
        return o
    }
    
    var horizontallyNegated: UIOffset {
        var o = self
        o.horizontal = self.horizontal.negated()
        return o
    }
    
    var verticallyNegated: UIOffset {
        var o = self
        o.vertical = self.vertical.negated()
        return o
    }
}

public extension UIOffset {
    
    func with(horizontal: CGFloat) -> UIOffset {
        var o = self
        o.horizontal = horizontal
        return o
    }
    
    func with(vertical: CGFloat) -> UIOffset {
        var o = self
        o.vertical = vertical
        return o
    }
}

public extension UIOffset {
    
    func adding(horizontal: CGFloat) -> UIOffset {
        var o = self
        o.horizontal += horizontal
        return o
    }
    
    func adding(vertical: CGFloat) -> UIOffset {
        var o = self
        o.vertical = vertical
        return o
    }
}

public extension UIOffset {
    
    func subtracting(horizontal: CGFloat) -> UIOffset {
        var o = self
        o.horizontal -= horizontal
        return o
    }
    
    func subtracting(vertical: CGFloat) -> UIOffset {
        var o = self
        o.vertical -= vertical
        return o
    }
}

#endif
