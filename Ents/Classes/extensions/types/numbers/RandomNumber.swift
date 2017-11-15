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
    associatedtype Base: BinaryInteger
    
    var value: Base { get }
}

public struct RandomNumber<I>: RandomNumberProtocol where I: BinaryInteger {
    public let value: I
    public init() {
        self.value = numericCast(arc4random()) as I
    }
}

public struct UpperBoundRandomNumber<I>: RandomNumberProtocol where I: BinaryInteger {
    public let value: I
    
    public init(_ upperBound: I) {
        self.init(upperBound: upperBound)
    }
    
    public init(upperBound: I) {
        let u = numericCast(upperBound) as UInt32
        self.value = numericCast(arc4random_uniform(u)) as I
    }
}

public struct RangedRandomNumber<I>: RandomNumberProtocol where I: BinaryInteger {
    public let value: I
    
    // interval [lower,upper)
    public init(lowerBound: I = I(0), upperBound: I) {
        precondition(lowerBound < upperBound)
        
        self.value = lowerBound + UpperBoundRandomNumber(upperBound - lowerBound).value
    }
}
