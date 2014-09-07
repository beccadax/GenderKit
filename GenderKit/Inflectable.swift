//
//  Inflectable.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/6/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

/// The Inflectable protocol represents a type that can be inflected to refer to 
/// one or more genders.
public protocol Inflectable {
    func inflectedString(genderLexicons lexicons: [GenderLexicon]) -> String
}

extension String: Inflectable {
    /// Plain Strings are Inflectable, but aren't actually altered by being 
    /// inflected.
    public func inflectedString(genderLexicons _: [GenderLexicon]) -> String {
        return self
    }
}
