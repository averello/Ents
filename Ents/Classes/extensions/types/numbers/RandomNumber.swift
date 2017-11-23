//
//  RandomNumber.swift
//  Ents
//
//  Created by Georges Boumis on 15/11/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public protocol RandomNumberProtocol {
    associatedtype Base: FixedWidthInteger
    
    var value: Base { get }
}

public struct RandomNumber<I>: RandomNumberProtocol where I: FixedWidthInteger {
    public let value: I
    public init() {
        var b = I(0)
        arc4random_buf(&b, MemoryLayout.size(ofValue: b))
        self.value = b
    }
}

fileprivate func random<S>(upperBound: S) -> S where S: SignedInteger, S: FixedWidthInteger {
    let max = S.max
    let range = max - max % upperBound
    var b = S(0)
    let u = S(upperBound)
    repeat {
        arc4random_buf(&b, MemoryLayout.size(ofValue: b))
        if b < 0 {
            if b == (-S.max-1) {
                b = abs(b+1)
            }
            else {
                b.negate()
            }
        }
    } while b >= range
    return b % u
}

fileprivate func random<U>(upperBound: U) -> U where U: UnsignedInteger, U: FixedWidthInteger {
    let max = U.max
    let range = max - max % upperBound
    var b = U(0)
    let u = U(upperBound)
    repeat {
        arc4random_buf(&b, MemoryLayout.size(ofValue: b))
    } while b >= range
    return b % u
}

fileprivate struct SignedUpperBoundRandomNumber<S>: RandomNumberProtocol where S: SignedInteger, S: FixedWidthInteger {
    fileprivate let value: S
    
    fileprivate init(_ upperBound: S) {
        self.init(upperBound: upperBound)
    }
    
    fileprivate init(upperBound: S) {
        self.value = random(upperBound: upperBound) as S
        assert(self.value <= upperBound)
    }
}

fileprivate struct UnsignedUpperBoundRandomNumber<U>: RandomNumberProtocol where U: UnsignedInteger, U: FixedWidthInteger {
    fileprivate let value: U
    
    fileprivate init(_ upperBound: U) {
        self.init(upperBound: upperBound)
    }
    
    fileprivate init(upperBound: U) {
        self.value = random(upperBound: upperBound) as U
        assert(self.value <= upperBound)
    }
}

public struct UpperBoundRandomNumber<S>: RandomNumberProtocol where S: FixedWidthInteger {
    public let value: S
    
    public init<Signed>(_ upperBound: Signed) where Signed: SignedInteger, Signed: FixedWidthInteger, Signed.Magnitude == S.Magnitude, Signed.Words == S.Words {
        self.init(upperBound: upperBound)
    }
    
    public init<Signed>(upperBound: Signed) where Signed: SignedInteger, Signed: FixedWidthInteger, Signed.Magnitude == S.Magnitude, Signed.Words == S.Words {
        self.value = S(random(upperBound: upperBound) as Signed)
        assert(self.value <= upperBound)
    }
    
    public init<Unsigned>(_ upperBound: Unsigned) where Unsigned: UnsignedInteger, Unsigned: FixedWidthInteger, Unsigned.Magnitude == S.Magnitude, Unsigned.Words == S.Words {
        self.init(upperBound: upperBound)
    }
    
    public init<Unsigned>(upperBound: Unsigned) where Unsigned: UnsignedInteger, Unsigned: FixedWidthInteger, Unsigned.Magnitude == S.Magnitude, Unsigned.Words == S.Words {
        self.value = S(random(upperBound: upperBound) as Unsigned)
        assert(self.value <= upperBound)
    }
}

public struct RangedRandomNumber<I>: RandomNumberProtocol where I: FixedWidthInteger {
    public let value: I
    
    // interval [lower,upper)
    public init<S>(lowerBound: S = S(0), upperBound: S) where S: SignedInteger, S: FixedWidthInteger, S.Magnitude == I.Magnitude, S.Words == I.Words {
        precondition(lowerBound < upperBound)
        
        self.value = numericCast(lowerBound + UpperBoundRandomNumber<S>(upperBound - lowerBound).value) as I
        assert(self.value >= lowerBound && self.value <= upperBound)
    }
    
    public init<U>(lowerBound: U = U(0), upperBound: U) where U: UnsignedInteger, U: FixedWidthInteger, U.Magnitude == I.Magnitude, U.Words == I.Words {
        precondition(lowerBound < upperBound)
        
        self.value = numericCast(lowerBound + UpperBoundRandomNumber<U>(upperBound - lowerBound).value) as I
        assert(self.value >= lowerBound && self.value <= upperBound)
    }
}

