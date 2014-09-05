//
//  all.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/5/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

internal func all<T, U>(a: T?, b: U?) -> (T, U)? {
    if let a = a {
        if let b = b {
            return (a, b)
        }
    }
    return nil
}

internal func all<T, U, V, W>(a: T?, b: U?, c: V?, d: W?) -> (T, U, V, W)? {
    if let a = a {
        if let b = b {
            if let c = c {
                if let d = d {
                    return (a, b, c, d)
                }
            }
        }
    }
    return nil
}
