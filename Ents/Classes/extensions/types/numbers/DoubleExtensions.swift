//
//  DoubleExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 26/07/2016.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
#if canImport(QuartzCore)
import QuartzCore

public extension Double {
    
    /// converts a `Double` instance to a `CGFloat` instance.
    var asCGFloat: QuartzCore.CGFloat {
        return QuartzCore.CGFloat(self)
    }
}

#endif
