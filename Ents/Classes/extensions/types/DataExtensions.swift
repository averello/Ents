//
//  DataExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 28/03/2019.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation


#if canImport(CommonCrypto)
import CommonCrypto

public extension Data {
    
    var md5Hash: Data? {
        if self.isEmpty {
            return nil
        }
        return self.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) -> Data? in
            guard let base = pointer.baseAddress else { return nil }
            let length = CC_MD5_DIGEST_LENGTH
            let count = Int(length)
            var digest = [UInt8](repeating: 0, count: count)
            CC_MD5(base, CC_LONG(pointer.count), &digest)
            return Data(bytes: digest, count: count)
        }
    }
    
    var hexEncoded: String {
        return self.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) -> String in
            return buffer.map({ String(format: "%02x", $0) }).joined()
        }
    }
}
#endif
