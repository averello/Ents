//
//  StringExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 28/03/2019.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

#if canImport(CommonCrypto)
import CommonCrypto

public extension String {
    
    var md5Hash: Data? {
        if self.isEmpty {
            return nil
        }
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        return data.md5Hash
    }
}
#endif
