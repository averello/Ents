//
//  ConditionalCollection.swift
//  BlackJack
//
//  Created by Georges Boumis on 22/11/2017.
//  Copyright © 2017 AbZorba Games. All rights reserved.
//

import Foundation

/// Non efficient unique collection based on == operator
public struct ConditionalCollection<Element>: Collection, RangeReplaceableCollection {
    fileprivate let _array: [Element]
    public typealias Condition<E> = (Element, [E]) -> Bool
    fileprivate let condition: Condition<Element>
    
    public init() {
        self.init(collection: [])
    }
    
    public init(condition: @escaping Condition<Element>) {
        self.init(collection: [], condition: condition)
    }
    
    public init(collection: [Element], condition: @escaping Condition<Element> = { _,_ in true }) {
        self.condition = condition
        var array: [Element] = Array<Element>()
        array.reserveCapacity(collection.count)
        collection.forEach { _,element in
            guard condition(element, array) else { return }
            array.append(element)
        }
        self._array = array
    }
    
    //MARK: Collection conformance
    public var startIndex: Int { return self._array.startIndex }
    public var endIndex: Int { return self._array.endIndex }
    public subscript(i: Int) -> Element { return self._array[i] }
    public func index(after i: Int) -> Int { return self._array.index(after: i) }
    
    //MARK: RangeReplaceableCollection conformance
    // performance non optimal
    public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, C.Iterator.Element == Element {
        var array = self._array
        array.replaceSubrange(subrange, with: newElements)
        self = ConditionalCollection(collection: array, condition: self.condition)
    }
}

extension ConditionalCollection: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        self.init(collection: elements)
    }
}

extension ConditionalCollection: CustomStringConvertible {
    
    public var description: String {
        return String(describing: type(of: self))
            + "\(self._array)"
    }
}
