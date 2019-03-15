//
//  TimedBlock.swift
//  Ents
//
//  Created by Georges Boumis on 26/08/2016.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
#if canImport(CoreFoundation)
import CoreFoundation

public func TimedBlock(_ block: () throws -> Void) rethrows -> CFTimeInterval {
    let chrono = Chronometer()
    try block()
    return chrono.difference
}

#endif
