//
//  PerfomingEach.swift
//  Ents
//
//  Created by Georges Boumis on 14/11/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension Collection {
    
    /// Calls the given closure on each element in the sequence in the same
    /// order as a for-in loop and returns the same collection
    public func perfomingEach(_ body: (Self.Iterator.Element) throws -> Void) rethrows -> Self {
        try self.forEach(body)
        return self
    }
}


/// A lazy iterator for "performing each" collections
/// order as a for-in loop and returns the same collection
public struct LazyPerfomingEachIterator<Base: IteratorProtocol>: IteratorProtocol {
    public typealias Element = Base.Element
    
    var base: Base
    let perform: (Base.Element) -> ()
    
    public mutating func next() -> LazyPerfomingEachIterator<Base>.Element? {
        guard let next = self.base.next() else { return nil }
        self.perform(next)
        return next
    }
}

/// A lazy "performing each" collection.
public struct LazyPerformingEachCollection<Base: Collection>
: LazyCollectionProtocol {
    
    public typealias Element = Base.Iterator.Element
    public typealias SubSequence = Base.SubSequence
    public typealias Index = Base.Index
    
    let base: Base
    let perform: (Element) -> Void
    
    public init(base: Base, perform: @escaping (Element) -> Void) {
        self.base = base
        self.perform = perform
    }
    
    public func makeIterator()
        -> LazyPerfomingEachIterator<Base.Iterator> {
        return LazyPerfomingEachIterator(
            base: self.base.makeIterator(),
            perform: self.perform)
    }
    
    public var count: Int { return self.base.count }
    public subscript(position: Index) -> Element { return self.base[position] }
    public var startIndex: Index { return self.base.startIndex }
    public var endIndex: Index { return self.base.endIndex }
    public func index(after i: Index) -> Index { return self.base.index(after: i) }
}

public extension LazyCollectionProtocol {
    
    /// lazily "perform each".
    public func perfomingEach(_ body: @escaping (Element) -> Void) -> LazyPerformingEachCollection<Self> {
        return LazyPerformingEachCollection(base: self, perform: body)
    }
}

