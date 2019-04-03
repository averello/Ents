//
//  TimeExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 19/08/2016.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public typealias Milliseconds = TimeInterval
public typealias Seconds = TimeInterval

public extension TimeInterval {
    
    /// the zero time interval
    static let zero: TimeInterval = TimeInterval(0)
    /// the instant time interval == 1ms
    static let instantly: TimeInterval = TimeInterval(1)

    /// one frame time, 16ms on a 60fps device
    static let oneFrame: TimeInterval = TimeInterval(16)

    /// Returns its value in milliseconds
    /// - note: The caller should know wether the time interval is in seconds
    var asMilliseconds: Milliseconds {
        return self * 1000.0
    }
    /// Returns its value in seconds
    /// - note: The caller should know wether the time interval is in milliseconds
    var asSeconds: Seconds {
        return self / 1000.0
    }

    /// Returns its value in minutes
    /// - note: the interval is considered to be in seconds
    var asMinutes: TimeInterval {
        return self / 60.0
    }

    /// Returns its value in hours
    /// - note: the interval is considered to be in seconds
    var asHours: TimeInterval {
        return self.asMinutes / 60.0
    }

    /// Returns its value in days
    /// - note: the interval is considered to be in seconds
    var asDays: TimeInterval {
        return self.asHours / 24.0
    }
}
