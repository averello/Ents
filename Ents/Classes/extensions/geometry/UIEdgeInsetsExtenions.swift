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
    
    public func inset(rect: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(rect, self)
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
