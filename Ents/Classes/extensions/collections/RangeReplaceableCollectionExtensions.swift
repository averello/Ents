//
//  RangeReplaceableCollectionExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 22/03/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension RangeReplaceableCollection {
    
    /// creates a new collection that was deprived of its last element
    public func dropingLast(_ n: Int = 1) -> Self  {
        guard n > 0 else { return self }
        return Self(self.dropLast(n))
    }
    
    /// creates a new collection that was deprived of its first element
    public func dropingFirst(_ n: Int = 1) -> Self  {
        guard n > 0 else { return self }
        return Self(self.dropFirst(n))
    }
}

public extension RangeReplaceableCollection {
    
    /// iterates over the elements before removing all of them from the collection
    public mutating func removeAll(_ block: (Self.Iterator.Element) throws -> Void) rethrows {
        try self.forEach { (_,e) in
            try block(e)
        }
        self.removeAll()
    }
    
    /// creates a new collection populated by the given element at the end
    ///
    ///     let a = ["1", "2", "3"]
    ///     let appended = a.appending(element: "4")
    ///     print(appended)
    ///     // prints "["1", "2", "3", "4"]"
    ///
    /// - Parameter element: the element to append
    /// - Returns: a new collection populated by the given element at the end
    public func appending(element: Self.Iterator.Element) -> Self {
        var mutant = self
        mutant.append(element)
        return mutant
    }
    
    /// creates a new collection populated by the given elements at the end
    ///
    ///     let a = ["1", "2", "3"]
    ///     let appended = a.appending(elementOf: ["4", "5"])
    ///     print(appended)
    ///     // prints "["1", "2", "3", "4", "5"]"
    ///
    /// - Parameter elementsOf: the elements to append
    /// - Returns: a new collection populated by the given elements at the end
    public func appending<S>(elementsOf newElements: S) -> Self where S : Sequence, Self.Element == S.Element {
        var mutant = self
        mutant.append(contentsOf: newElements)
        return mutant
    }
    
    /// creates a new collection populated by the given element at the start
    ///
    ///     let a = ["1", "2", "3"]
    ///     let prepended = a.prepending(element: "0")
    ///     print(prepended)
    ///     // prints "["0", "1", "2", "3"]"
    ///
    /// - Parameter element: the element to prepend
    /// - Returns: creates a new collection populated by the given element at the start
    public func prepending(element: Self.Iterator.Element) -> Self {
        var mutant = self
        mutant.insert(element, at: mutant.startIndex)
        return mutant
    }
    
    /// creates a new collection populated by the given elements at the start
    ///
    ///     let a = ["1", "2", "3"]
    ///     let prepended = a.prepending(element: ["-1", "0"])
    ///     print(prepended)
    ///     // prints "["-1", "0", "1", "2", "3"]"
    ///
    /// - Parameter elementsOf: the elements to prepend
    /// - Returns: creates a new collection populated by the given elements at the start
    public func prepending<C>(elementsOf newElements: C) -> Self where C: Collection, Self.Element == C.Element {
        var mutant = self
        mutant.insert(contentsOf: newElements, at: mutant.startIndex)
        return mutant
    }
    
    // sieve() returns [Self.Iterator.Element],
    /// - Parameter predicate: the predicate
    /// - Returns: a new collection deprived of the elemnets that satisfy the given predicate
    /// - SeeAlso: sieve(:)
    public func removing(elementsSatisfying predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Self {
        return try Self(self.sieve(predicate))
    }
    
    /// Remove elements that satisfy the given predicate
    /// - Parameter predicate: the predicate
    /// - SeeAlso: sieve(:)
    public mutating func remove(elementsSatisfying predicate: (Self.Iterator.Element) throws -> Bool) rethrows {
        self = try self.removing(elementsSatisfying: predicate)
    }
}

extension RangeReplaceableCollection where Self.Element: AnyObject {
    
    public mutating func remove(element: Element) {
        self.remove(elementsSatisfying: { (e: Element) -> Bool in
            return (e === element)
        })
    }
}

public extension RangeReplaceableCollection
    where Self.Iterator.Element: Comparable,
    Self.Index: BinaryInteger,
Self.SubSequence.Iterator.Element == Self.Iterator.Element {

    public func stableSorted() -> Self {
        var copy = self
        copy.stableSort()
        return copy
    }

    public mutating func stableSort() {
        var tmp = [Self.Iterator.Element]()
        tmp.reserveCapacity(self.count)

        func merge(lo: Self.Index, mi: Self.Index, hi: Self.Index) {
            tmp.removeAll(keepingCapacity: true)

            var i = lo, j = mi
            while i != mi && j != hi {
                let sj = self[j], si = self[i]
                if sj < si {
                    tmp.append(sj)
                    j = self.index(after: j)
                }
                else {
                    tmp.append(si)
                    i = self.index(after: i)
                }
            }
            print("i = \(i), j = \(j), (lo,mi,hi) = (\(lo),\(mi),\(hi))")
            tmp.append(contentsOf: self[i..<mi])
            tmp.append(contentsOf: self[j..<hi])
            self.replaceSubrange(lo..<hi, with: tmp)
        }

        var size = 1
        let start = Int(self.startIndex)
        let end = Int(self.endIndex)
        while size < end {
            for lo in stride(from: start, to: end-size, by: size * 2) {
                merge(lo: Self.Index(lo),
                      mi: Self.Index(lo + size),
                      hi: Self.Index((lo + size * 2).minimum(end)))
            }
            size *= 2
        }
    }
}

public extension RangeReplaceableCollection
    where Self.Index: BinaryInteger,
Self.SubSequence.Iterator.Element == Self.Iterator.Element {

    public func stableSorted(_ areInIncreasingOrder: @escaping (Self.Iterator.Element, Self.Iterator.Element) -> Bool) -> Self {
        var copy = self
        copy.stableSort(areInIncreasingOrder)
        return copy
    }

    public mutating func stableSort(_ areInIncreasingOrder: @escaping (Self.Iterator.Element, Self.Iterator.Element) -> Bool) {
        var tmp = [Self.Iterator.Element]()
        tmp.reserveCapacity(self.count)

        func merge(lo: Self.Index, mi: Self.Index, hi: Self.Index) {
            tmp.removeAll(keepingCapacity: true)

            var i = lo, j = mi
            while i != mi && j != hi {
                let sj = self[j], si = self[i]
                if areInIncreasingOrder(sj, si) {
                    tmp.append(sj)
                    j = self.index(after: j)
                }
                else {
                    tmp.append(si)
                    i = self.index(after: i)
                }
            }
            print("i = \(i), j = \(j), (lo,mi,hi) = (\(lo),\(mi),\(hi))")
            tmp.append(contentsOf: self[i..<mi])
            tmp.append(contentsOf: self[j..<hi])
            self.replaceSubrange(lo..<hi, with: tmp)
        }

        var size = 1
        let start = Int(self.startIndex)
        let end = Int(self.endIndex)
        while size < end {
            for lo in stride(from: start, to: end-size, by: size * 2) {
                merge(lo: Self.Index(lo),
                      mi: Self.Index(lo + size),
                      hi: Self.Index((lo + size * 2).minimum(end)))
            }
            size *= 2
        }
    }
}
