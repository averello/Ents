//
//  DataExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 28/03/2019.
//

import Foundation


#if canImport(CommonCrypto)
import CommonCrypto

public extension Data {
    
    var md5Hash: Data? {
        if self.isEmpty {
            return nil
        }
        return self.withUnsafeBytes { (pointer: UnsafePointer<UInt8>) -> Data in
            let length = CC_MD5_DIGEST_LENGTH
            var result = [UInt8](repeating: 0, count: Int(length))
            CC_MD5(pointer, CC_LONG(length), &result)
            return Data(bytes: result)
        }
    }
    
    var hexEncoded: String {
        return self.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) -> String in
            return buffer.map({ String(format: "%02x", $0) }).joined()
        }
    }
}
#endif
