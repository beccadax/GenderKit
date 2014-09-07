//
//  Genderable.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/5/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

/// A Genderable type is one with an inherent gender. It provides access to a GenderLexicon object that should be used to describe it.
public protocol Genderable {
    /// Returns the GenderLexicon that should be used to describe this instance.
    var genderLexicon: GenderLexicon { get }
}

// These conformances are not, strictly speaking, semantically correct, but they're 
// very handy.
extension Gender: Genderable {}
extension GenderLexicon: Genderable {
    public var genderLexicon: GenderLexicon {
        return self
    }
}

// Front-end functions for inflection. The main value of these functions is not in 
// anything they do themselves, but that they force the string parameter to be an 
// InflectableString, which helps disambiguate in certain situations.

public func inflect(string: InflectableString, forGenderLexicons lexicons: [GenderLexicon]) -> String {
    return string.inflectedString(genderLexicons: lexicons)
}

public func inflect(string: InflectableString, forGenders genders: [Genderable]) -> String {
    return inflect(string, forGenderLexicons: genders.map { $0.genderLexicon })
}

public func inflect(string: InflectableString, forGenders genders: Genderable...) -> String {
    return inflect(string, forGenders: genders)
}

public func inflect(string: InflectableString, forGender gender: Genderable) -> String {
    return inflect(string, forGenders: gender)
}
