//
//  ReadabilityUtilities.swift
//  Ents
//
//  Created by Georges Boumis on 17/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public func by<Element>(_ element: Element) -> Element {
    return element
}

@available(swift 3.1)
@available(swift, deprecated: 3.2)
@available(swift, obsoleted: 4.0, message: "doesn't work well with refererces types.")
public func with<Element>(_ o: Element, _ block: (inout Element) -> Void) -> Element {
    var e = o
    block(&e)
    return e
}

@available(swift, introduced: 4.0)
public func with<Element>(_ e: Element, _ block: (Element) -> Void) -> Element where Element: AnyObject {
    block(e)
    return e
}
