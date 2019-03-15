//
//  Value.swift
//  Ents
//
//  Created by Georges Boumis on 13/06/2016.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public protocol Value: Comparable, CustomStringConvertible {
    associatedtype T: Comparable
    var value: T { get }
    init(value: T)
}

//MARK: Act as a CustomStringConvertible

extension Value {

    public var description: String {
        return "\(self.value)"
    }
}

//MARK: Act as a Equatable

extension Value {

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return (lhs.value == rhs.value)
    }
}

//MARK: Act as a Comparable

extension Value {

    public static func <(lhs: Self, rhs: Self) -> Bool {
        return (lhs.value < rhs.value)
    }
}

//MARK: Act as a Hashable

extension Value where Self: Hashable, T: Hashable {

    public var hashValue: Int {
        return self.value.hashValue
    }
}

//MARK: Act as a IntegerArithmetic

extension Value where T: BinaryInteger {

//    public static func ==(lhs: Self, rhs: T) -> Bool {
//        return (lhs.value == rhs)
//    }

    public static func +(lhs: Self, rhs: Self) -> Self {
        return Self(value: lhs.value + rhs.value)
    }

    public static func -(lhs: Self, rhs: Self) -> Self {
        return Self(value: lhs.value - rhs.value)
    }

    public static func *(lhs: Self, rhs: Self) -> Self {
        return Self(value: lhs.value * rhs.value)
    }

    public static func /(lhs: Self, rhs: Self) -> Self {
        return Self(value: lhs.value / rhs.value)
    }

    public static func %(lhs: Self, rhs: Self) -> Self {
        return Self(value: lhs.value % rhs.value)
    }
    
    public func adding(_ other: Self) -> Self {
        return self + other
    }
    public func subtracting(_ other: Self) -> Self {
        return self - other
    }
    public func multiplied(by other: Self) -> Self {
        return self * other
    }
    public func divided(by other: Self) -> Self {
        return self / other
    }
    
    
//    public func adding(_ other: T) -> Self {
//        return Self(value: self.value + other)
//    }
//    public func subtracting(_ other: T) -> Self {
//        return Self(value: self.value - other)
//    }
//    public func multiplied(by other: T) -> Self {
//        return Self(value: self.value * other)
//    }
//    public func divided(by other: T) -> Self {
//        return Self(value: self.value / other)
//    }


//    //
//    public static func +(lhs: Self, rhs: T) -> Self {
//        return Self(value: lhs.value + rhs)
//    }
//
//    public static func -(lhs: Self, rhs: T) -> Self {
//        return Self(value: lhs.value - rhs)
//    }
//
//    public static func *(lhs: Self, rhs: T) -> Self {
//        return Self(value: lhs.value * rhs)
//    }
//
//    public static func /(lhs: Self, rhs: T) -> Self {
//        return Self(value: lhs.value / rhs)
//    }
//
//    public static func %(lhs: Self, rhs: T) -> Self {
//        return Self(value: lhs.value % rhs)
//    }

    public static func +=(lhs: inout Self, rhs: Self) {
        lhs = Self(value: lhs.value + rhs.value)
    }

    public static func -=(lhs: inout Self, rhs: Self) {
        lhs = Self(value: lhs.value - rhs.value)
    }

    public static func *=(lhs: inout Self, rhs: Self) {
        lhs = Self(value: lhs.value * rhs.value)
    }

    public static func /=(lhs: inout Self, rhs: Self) {
        lhs = Self(value: lhs.value / rhs.value)
    }

    public static func %=(lhs: inout Self, rhs: Self) {
        lhs = Self(value: lhs.value % rhs.value)
    }
    
    //
    
    public mutating func add(_ other: Self) {
        self += other
    }
    public mutating func subtract(_ other: Self) {
        self -= other
    }
    public mutating func multiply(by other: Self) {
        self *= other
    }
    public mutating func divide(by other: Self) {
        self /= other
    }
    
    
//    public mutating func add(_ other: T) {
//        self += other
//    }
//    public mutating func subtract(_ other: T) {
//        self -= other
//    }
//    public mutating func multiply(by other: T) {
//        self *= other
//    }
//    public mutating func divide(by other: T) {
//        self /= other
//    }

    //

//    public static func +=(lhs: inout Self, rhs: T) {
//        lhs = Self(value: lhs.value + rhs)
//    }
//
//    public static func -=(lhs: inout Self, rhs: T) {
//        lhs = Self(value: lhs.value - rhs)
//    }
//
//    public static func *=(lhs: inout Self, rhs: T) {
//        lhs = Self(value: lhs.value * rhs)
//    }
//
//    public static func /=(lhs: inout Self, rhs: T) {
//        lhs = Self(value: lhs.value / rhs)
//    }
//
//    public static func %=(lhs: inout Self, rhs: T) {
//        lhs = Self(value: lhs.value % rhs)
//    }
    
    // minimum/maximum
    
    
    public func minimum(_ other: Self) -> Self {
        return Self(value: self.value.minimum(other.value))
    }
    
    public func maximum(_ other: Self) -> Self {
        return Self(value: self.value.maximum(other.value))
    }
    
    
//    public func minimum(_ other: T) -> Self {
//        return Self(value: self.value.minimum(other))
//    }
//
//    public func maximum(_ other: T) -> Self {
//        return Self(value: self.value.maximum(other))
//    }
}

extension Value where T: FixedWidthInteger {
    
    public static func addWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        let res = lhs.value.addingReportingOverflow(rhs.value)
        return (Self(value: res.0), overflow: res.overflow)
    }
    
    public static func subtractWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        let res = lhs.value.subtractingReportingOverflow(rhs.value)
        return (Self(value: res.0), overflow: res.overflow)
    }
    
    public static func multiplyWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        let res = lhs.value.multipliedReportingOverflow(by: rhs.value)
        return (Self(value: res.0), overflow: res.overflow)
    }
    
    public static func divideWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        let res = lhs.value.dividedReportingOverflow(by: rhs.value)
        return (Self(value: res.0), overflow: res.overflow)
    }
    
    public static func remainderWithOverflow(_ lhs: Self, _ rhs: Self) -> (Self, overflow: Bool) {
        let res = lhs.value.remainderReportingOverflow(dividingBy: rhs.value)
        return (Self(value: res.0), overflow: res.overflow)
    }
    
    //

//    public static func addWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
//        let res = lhs.value.addingReportingOverflow(rhs)
//        return (Self(value: res.0), overflow: res.overflow)
//    }
//
//    public static func subtractWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
//        let res = lhs.value.subtractingReportingOverflow(rhs)
//        return (Self(value: res.0), overflow: res.overflow)
//    }
//
//    public static func multiplyWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
//        let res = lhs.value.multipliedReportingOverflow(by: rhs)
//        return (Self(value: res.0), overflow: res.overflow)
//    }
//
//    public static func divideWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
//        let res = lhs.value.dividedReportingOverflow(by: rhs)
//        return (Self(value: res.0), overflow: res.overflow)
//    }
//
//    public static func remainderWithOverflow(_ lhs: Self, _ rhs: T) -> (Self, overflow: Bool) {
//        let res = lhs.value.remainderReportingOverflow(dividingBy: rhs)
//        return (Self(value: res.0), overflow: res.overflow)
//    }
}

//MARK: Act as a SignedInteger

extension Value where T: SignedInteger {

    public func absolute() -> Self {
        return Self(value: self.value.absolute())
    }

    public func negated() -> Self {
        return Self(value: self.value.negated())
    }

    public mutating func negate() {
        self = self.negated()
    }
}

//MARK: Act as a FloatingPoint

extension Value where T: FloatingPoint {

    public func adding(_ other: Self) -> Self {
        return Self(value: self.value + other.value)
    }
    public func subtracting(_ other: Self) -> Self {
        return Self(value: self.value - other.value)
    }
    public func multiplied(by other: Self) -> Self {
        return Self(value: self.value * other.value)
    }
    public func divided(by other: Self) -> Self {
        return Self(value: self.value / other.value)
    }


//    public func adding(_ other: T) -> Self {
//        return Self(value: self.value + other)
//    }
//    public func subtracting(_ other: T) -> Self {
//        return Self(value: self.value - other)
//    }
//    public func multiplied(by other: T) -> Self {
//        return Self(value: self.value * other)
//    }
//    public func divided(by other: T) -> Self {
//        return Self(value: self.value / other)
//    }


    public func negated() -> Self {
        return Self(value: self.value.negated())
    }

    public func absolute() -> Self {
        return Self(value: self.value.absolute())
    }


    public func minimum(_ other: Self) -> Self {
        return Self(value: self.value.minimum(other.value))
    }

    public func maximum(_ other: Self) -> Self {
        return Self(value: self.value.maximum(other.value))
    }
    
//    public func minimum(_ other: T) -> Self {
//        return Self(value: self.value.minimum(other))
//    }
//
//    public func maximum(_ other: T) -> Self {
//        return Self(value: self.value.maximum(other))
//    }
}

//MARK: Act as a Strideable

extension Value where T: Strideable {

    public func distance(to other: Self) -> T.Stride {
        return self.value.distance(to: other.value)
    }

    public func advanced(by amount: T.Stride) -> Self {
        return Self(value: self.value.advanced(by: amount))
    }
}


//MARK: Operators

prefix public func -<V>(x: V) -> V where V: Value, V.T : SignedNumeric {
    return V(value: -x.value)
}

prefix public func +<V>(x: V) -> V where V: Value {
    return x
}

public func +<V>(lhs: V, rhs: V) -> V where V: Value, V.T: Numeric {
    return V(value: lhs.value + rhs.value)
}

public func -<V>(lhs: V, rhs: V) -> V where V: Value, V.T: Numeric {
    return V(value: lhs.value - rhs.value)
}

public func *<V>(lhs: V, rhs: V) -> V where V: Value, V.T: Numeric {
    return V(value: lhs.value * rhs.value)
}

public func /<V>(lhs: V, rhs: V) -> V where V: Value, V.T: BinaryInteger {
    return V(value: lhs.value / rhs.value)
}

public func %<V>(lhs: V, rhs: V) -> V where V: Value, V.T: BinaryInteger {
    return V(value: lhs.value % rhs.value)
}


//MARK: Act as a Collection

extension Value where T: Collection {
    
    public typealias Element = T.Iterator.Element
    public typealias Index = T.Index
    public typealias Iterator = T.Iterator

    public func makeIterator() -> Iterator { return self.value.makeIterator() }
    public var startIndex: Index { return self.value.startIndex }
    public var endIndex: Index { return self.value.endIndex }
    public var count: Int { return self.value.count }
    public subscript(i: Index) -> Element { return self.value[i] }
    public func index(after i: Index) -> Index { return self.value.index(after: i) }
}
