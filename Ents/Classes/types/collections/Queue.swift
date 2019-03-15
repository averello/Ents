//
//  Queue.swift
//  Ents
//
//  Created by Georges Boumis on 09/05/2017.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

/// A type that can 'enqueue' and 'dequeue' elements.
public protocol Queue: Collection {
    
    /// Enqueue 'element' to 'self'
    mutating func enqueue(_ element: Element)
    /// Dequeue an element from 'self'
    mutating func dequeue() -> Element?
}

