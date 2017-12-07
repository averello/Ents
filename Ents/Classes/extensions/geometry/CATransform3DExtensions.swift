//
//  CATTransform3D.swift
//  Ents
//
//  Created by Georges Boumis on 26/08/16.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension CATransform3D {
    
    /// create a NSValue from this instance of `CATransform3D`.
    public var value: NSValue {
        return NSValue(caTransform3D: self)
    }
}

public extension CATransform3D {
    
    /// create a CGAffineTransform from this instance of `CATransform3D`.
    public var affine: CGAffineTransform {
        return CATransform3DGetAffineTransform(self)
    }
    
    /// Returns true if the receiver can be represented exactly by an affine transform.
    public var isAffine: Bool {
        return CATransform3DIsAffine(self)
    }
    
    /// Returns true if the receiver is the identity transform.
    public var isIdentity: Bool {
        return CATransform3DIsIdentity(self)
    }
}


public extension CATransform3D {
    
    /// concatenate this instance of `CATransform3D` with another instance of `CATransform3D`.
    public mutating func concatenate(_ t: CATransform3D) {
        self = self.concatenating(t)
    }
    
    /// concatenates this instance of `CATransform3D` with another instance of `CATransform3D`
    /// and returns a new `CATransform3D` instance.
    public func concatenating(_ t: CATransform3D) -> CATransform3D {
        return CATransform3DConcat(self, t)
    }
}

public extension CATransform3D {
    
    /// Creates a transform that rotates by 'angle' radians about the vector
    /// '(x, y, z)'. If the vector has length zero the identity transform is
    /// returned.
    public init(rotation angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) {
        self = CATransform3DMakeRotation(angle, x, y, z)
    }
    
    /// Rotate by 'angle' radians about the vector '(x, y, z)'.
    /// If the vector has zero length the behavior is undefined:
    /// t' = rotation(angle, x, y, z) * t.
    /// - Parameter angle: the angle in radians
    public mutating func rotate(by angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) {
        self = self.rotating(by: angle, x: x, y: y, z: z)
    }
    
    /// Rotate by 'angle' radians about the vector '(x, y, z)' and return
    /// the result. If the vector has zero length the behavior is undefined:
    /// t' = rotation(angle, x, y, z) * t.
    /// - Parameter angle: the angle in radians
    public func rotating(by angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D {
        return CATransform3DRotate(self, angle, x, y, z)
    }
}

public extension CATransform3D {
    
    /// Creates a transform that scales by `(x, y, z)':
    /// t' = [x 0 0 0; 0 y 0 0; 0 0 z 0; 0 0 0 1].
    public init(scaleX x: CGFloat, y: CGFloat, z: CGFloat) {
        self = CATransform3DMakeScale(x, y, y)
    }
    
    /// Scale by '(x, y, z)'.
    /// t' = scale(x, y, z) * t.
    public mutating func scale(x: CGFloat, y: CGFloat, z: CGFloat) {
        self = self.scaling(x: x, y: y, z: z)
    }
    
    /// Scale by '(x, y, z)' and return the result:
    /// t' = scale(x, y, z) * t.
    public func scaling(x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D {
        return CATransform3DScale(self, x, y, z)
    }
}

public extension CATransform3D {
    
    /// Returns a transform that translates by '(x, y, z)':
    /// t' =  [1 0 0 0; 0 1 0 0; 0 0 1 0; x y z 1].
    public init(translateX x: CGFloat, y: CGFloat, z: CGFloat) {
        self = CATransform3DMakeTranslation(x, y, z)
    }
    
    /// Translates by '(x, y, z)':
    /// t' =  [1 0 0 0; 0 1 0 0; 0 0 1 0; x y z 1].
    public mutating func translate(x: CGFloat, y: CGFloat, z: CGFloat){
        self = self.translating(x: x, y: y, z: z)
    }
    
    /// Returns a transform that translates by '(x, y, z)':
    /// t' =  [1 0 0 0; 0 1 0 0; 0 0 1 0; x y z 1].
    public func translating(x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D {
        return CATransform3DTranslate(self, x, y, z)
    }
}

public extension CATransform3D {
    
    /// Inverts the receiver. Stays at the original matrix if the receiver
    /// has no inverse.
    public mutating func invert() {
        self = self.inverted
    }
    
    /// Invert and return the result. Returns the original matrix if the receiver
    /// has no inverse.
    public var inverted: CATransform3D {
        return CATransform3DInvert(self)
    }
}

extension CATransform3D: Equatable {
    
    public static func == (lhs: CATransform3D, rhs: CATransform3D) -> Bool {
        return CATransform3DEqualToTransform(lhs, rhs)
    }
}
