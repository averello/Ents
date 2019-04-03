//
//  CGFloatExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 07/07/2016.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
#if canImport(CoreGraphics)
import CoreGraphics

extension CGFloat {
    
    /// converts this `CGFloat` instance to a `Float` instance.
    public var asFloat: Float {
        return Float(self)
    }

    /// converts this `CGFloat` instance to a `Double` instance.
    public var asDouble: Double {
        return Double(self)
    }
}


public extension CGFloat {
    
    /// returns the minimum of this `CGFloat` instance and a `Int` instance.
    func minimum(_ other: Int) -> CGFloat {
        return self.minimum(CGFloat(other))
    }

    /// returns the minimum of this `CGFloat` instance and a `Float` instance.
    func minimum(_ other: Float) -> CGFloat {
        return self.minimum(CGFloat(other))
    }

    /// returns the maximum of this `CGFloat` instance and a `Int` instance.
    func maximum(_ other: Int) -> CGFloat {
        return self.maximum(CGFloat(other))
    }

    /// returns the maximum of this `CGFloat` instance and a `Float` instance.
    func maximum(_ other: Float) -> CGFloat {
        return self.maximum(CGFloat(other))
    }
}

public extension CGFloat {
    
    func isDifferent(from other: Int) -> Bool {
        return self.isDifferent(from: CGFloat(other))
    }

    func isDifferent(from other: Float) -> Bool {
        return self.isDifferent(from: CGFloat(other))
    }
}

public extension CGFloat {
    
    var asNumber: NSNumber {
        return NSNumber(value: CGFloat.NativeType(self))
    }
}

public extension CGFloat {
    
    func power(_ p: Double) -> Double {
        return Foundation.pow(Double(self), p)
    }

    func power(_ p: Int) -> Double {
        return self.power(Double(p))
    }

    func power(_ p: Float) -> Double {
        return self.power(Double(p))
    }

    var square: Double {
        return self.power(2.0)
    }
    
    var cube: Double {
        return self.power(3.0)
    }
}

#endif
