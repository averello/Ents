//
//  UIOffsetExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 13/04/2018.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
import UIKit

public extension UIOffset {
    
    public var negated: UIOffset {
        var o = self
        o.horizontal = self.horizontal.negated()
        o.vertical = self.vertical.negated()
        return o
    }
    
    public var horizontallyNegated: UIOffset {
        var o = self
        o.horizontal = self.horizontal.negated()
        return o
    }
    
    public var verticallyNegated: UIOffset {
        var o = self
        o.vertical = self.vertical.negated()
        return o
    }
}

public extension UIOffset {
    
    public func with(horizontal: CGFloat) -> UIOffset {
        var o = self
        o.horizontal = horizontal
        return o
    }
    
    public func with(vertical: CGFloat) -> UIOffset {
        var o = self
        o.vertical = vertical
        return o
    }
}

public extension UIOffset {
    
    public func adding(horizontal: CGFloat) -> UIOffset {
        var o = self
        o.horizontal += horizontal
        return o
    }
    
    public func adding(vertical: CGFloat) -> UIOffset {
        var o = self
        o.vertical = vertical
        return o
    }
}

public extension UIOffset {
    
    public func subtracting(horizontal: CGFloat) -> UIOffset {
        var o = self
        o.horizontal -= horizontal
        return o
    }
    
    public func subtracting(vertical: CGFloat) -> UIOffset {
        var o = self
        o.vertical -= vertical
        return o
    }
}
