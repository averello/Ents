//
//  BinaryFloatingPointExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 19/08/2017.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
import QuartzCore

public extension BinaryFloatingPoint
    where Self.RawSignificand == Double.RawSignificand, Self.RawExponent == Double.RawExponent {
    
    /// converts this `Double`-like instance to a `NSNumber` instance.
    public var asNumber: NSNumber {
        return NSNumber(value: Double(sign: self.sign,
                                      exponentBitPattern: self.exponentBitPattern,
                                      significandBitPattern: self.significandBitPattern))
    }
    
    /// Returns a floating-point value that is raised to the power of `p`.
    /// - parameter p: a floating-point power.
    public func power(_ p: Self) -> Self {
        let lhs = Double(sign: self.sign,
                        exponentBitPattern: self.exponentBitPattern,
                        significandBitPattern: self.significandBitPattern)
        let rhs = Double(sign: p.sign,
                        exponentBitPattern: p.exponentBitPattern,
                        significandBitPattern: p.significandBitPattern)
        let result = Foundation.pow(lhs, rhs)
        return Self(sign: result.sign,
                    exponentBitPattern: result.exponentBitPattern,
                    significandBitPattern: result.significandBitPattern)
    }
    
    /// Returns a floating-point value that is raised to the power of `p`.
    /// - parameter p: an integer power.
    public func power<I>(_ p: I) -> Self where I: BinaryInteger {
        let lhs = Double(sign: self.sign,
                        exponentBitPattern: self.exponentBitPattern,
                        significandBitPattern: self.significandBitPattern)
        
        let result = { () -> Double in
            if I.isSigned {
                return Foundation.pow(lhs, Double(numericCast(p) as Int64))
            }
            else {
                return Foundation.pow(lhs, Double(numericCast(p) as UInt64))
            }
            
        }()
        return Self(sign: result.sign,
                    exponentBitPattern: result.exponentBitPattern,
                    significandBitPattern: result.significandBitPattern)
    }
    
    /// returns the square value of this instance.
    public var square: Self {
        return self.power(2)
    }
    
    /// returns the cube value of this instance.
    public var cube: Self {
        return self.power(3)
    }
}


public extension BinaryFloatingPoint
    where Self.RawSignificand == Float.RawSignificand, Self.RawExponent == Float.RawExponent {
    
    /// converts this `Float`-like instance to a `NSNumber` instance.
    public var asNumber: NSNumber {
        return NSNumber(value: Float(sign: self.sign,
                                     exponentBitPattern: self.exponentBitPattern,
                                     significandBitPattern: self.significandBitPattern))
    }
    
    /// Returns a floating-point value that is raised to the power of `p`.
    /// - parameter p: a floating-point power.
    public func power(_ p: Self) -> Self {
        let lhs = Float(sign: self.sign,
                        exponentBitPattern: self.exponentBitPattern,
                        significandBitPattern: self.significandBitPattern)
        let rhs = Float(sign: p.sign,
                        exponentBitPattern: p.exponentBitPattern,
                        significandBitPattern: p.significandBitPattern)
        let result = Foundation.powf(lhs, rhs)
        return Self(sign: result.sign,
                    exponentBitPattern: result.exponentBitPattern,
                    significandBitPattern: result.significandBitPattern)
    }
    
    /// Returns a floating-point value that is raised to the power of `p`.
    /// - parameter p: an integer power.
    public func power<I>(_ p: I) -> Self where I: BinaryInteger {
        let lhs = Float(sign: self.sign,
                        exponentBitPattern: self.exponentBitPattern,
                        significandBitPattern: self.significandBitPattern)
        
        let result = { () -> Float in
            if I.isSigned {
                return Foundation.powf(lhs, Float(numericCast(p) as Int64))
            }
            else {
                return Foundation.powf(lhs, Float(numericCast(p) as UInt64))
            }
            
        }()
        return Self(sign: result.sign,
                    exponentBitPattern: result.exponentBitPattern,
                    significandBitPattern: result.significandBitPattern)
    }

    /// returns the square value of this instance.
    public var square: Self {
        return self.power(2)
    }
    
    /// returns the cube value of this instance.
    public var cube: Self {
        return self.power(3)
    }
}
