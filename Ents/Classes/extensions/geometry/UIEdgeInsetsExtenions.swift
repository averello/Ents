//
//  UIEdgeInsetsExtenions.swift
//  Ents
//
//  Created by Georges Boumis on 30/03/2018.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
import UIKit

public extension UIEdgeInsets {
    
    public var horizontalInset: CGFloat {
        return self.left + self.right
    }
    
    public var verticalInset: CGFloat {
        return self.top + self.bottom
    }
}

public extension UIEdgeInsets {

    public var topOffset: UIOffset {
        return UIOffset(horizontal: 0, vertical: self.top)
    }

    public var bottomOffset: UIOffset {
        return UIOffset(horizontal: 0, vertical: -self.bottom)
    }

    public var leftOffset: UIOffset {
        return UIOffset(horizontal: self.left, vertical: 0)
    }

    public var rightOffset: UIOffset {
        return UIOffset(horizontal: -self.right, vertical: 0)
    }
}

public extension UIEdgeInsets {

    public var topLeftOffset: UIOffset {
        return UIOffset(horizontal: self.left, vertical: self.top)
    }

    public var topRightOffset: UIOffset {
        return UIOffset(horizontal: -self.right, vertical: self.top)
    }

    public var bottomLeftOffset: UIOffset {
        return UIOffset(horizontal: self.left, vertical: -self.bottom)
    }

    public var bottomRightOffset: UIOffset {
        return UIOffset(horizontal: -self.right, vertical: -self.bottom)
    }
}

public extension UIEdgeInsets {
    
    public func inset(rect: CGRect) -> CGRect {
        return rect.inset(by: self)
    }
    
    public enum Dimension {
        case horizontal
        case vertical
    }
    
    public func inset(size: CGSize, dimension: UIEdgeInsets.Dimension) -> CGSize {
        switch dimension {
        case UIEdgeInsets.Dimension.horizontal:
            return size.subtracting(width: self.horizontalInset)
        case UIEdgeInsets.Dimension.vertical:
            return size.subtracting(height: self.verticalInset)
        }
    }
}

public extension UIEdgeInsets {
    
    public var horizontalInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: self.left,
                            bottom: 0,
                            right: self.right)
    }
    
    public var verticalInsets: UIEdgeInsets {
        return UIEdgeInsets(top: self.top,
                            left: 0,
                            bottom: self.bottom,
                            right: 0)
    }
}
