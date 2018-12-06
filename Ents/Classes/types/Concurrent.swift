//
//  Concurrent.swift
//  Ents
//
//  Created by Georges Boumis on 06/12/2018.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

final public class Concurrent<A> {
    final private var _value: A
    final private let queue = DispatchQueue(label: "Ents.Concurrent")

    public init(_ value: A) {
        self._value = value
    }

    final public var value: A {
        return self.queue.sync { _value }
    }

    final public func atomically(_ transform: (inout A) -> Void) {
        self.queue.sync {
            transform(&self._value)
        }
    }
}
