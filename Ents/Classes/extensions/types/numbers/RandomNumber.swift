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

public struct UpperBoundRandomNumber<I>: RandomNumberProtocol where I: FixedWidthInteger {
    public let value: I
    
    public init(_ upperBound: I) {
        self.init(upperBound: upperBound)
    }
    
    public init(upperBound: I) {
        let max = I.max
        let range = max - max % upperBound
        
        // Generate arbitrary-bit random value in a range that is
        // divisible by upperBound:
        var b = I(0)
        let u = upperBound
        repeat {
            arc4random_buf(&b, MemoryLayout.size(ofValue: b))
        } while b >= range
        self.value = b % u
    }
}

public struct RangedRandomNumber<I>: RandomNumberProtocol where I: FixedWidthInteger {
    public let value: I
    
    // interval [lower,upper)
    public init(lowerBound: I = I(0), upperBound: I) {
        precondition(lowerBound < upperBound)
        
        self.value = lowerBound + UpperBoundRandomNumber(upperBound - lowerBound).value
    }
}

