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

/// Helper to return the subject pronoun with an initial cap. Use this where "He", "She", or "They" would go in a sentence.
public func They(subject: Genderable) -> String {
    return subject.genderLexicon.subjectPronoun
}

/// Helper to return the subject pronoun lowercased.  Use this where "he", "she", or "they" would go in a sentence.
public func they(subject: Genderable) -> String {
    return They(subject).lowercaseString
}

/// Helper to return the object pronoun with an initial cap. Use this where "Him", "Her", or "Them" would go in a sentence.
public func Them(object: Genderable) -> String {
    return object.genderLexicon.objectPronoun
}

/// Helper to return the object pronoun lowercased. Use this where "him", "her", or "them" would go in a sentence.
public func them(object: Genderable) -> String {
    return Them(object).lowercaseString
}

/// Helper to return the possessive determine pronoun with an initial cap. Use this where "His", "Her", or "Their" would go in a sentence.
public func Their(possessiveDeterminer: Genderable) -> String {
    return possessiveDeterminer.genderLexicon.possessiveDeterminerPronoun
}

/// Helper to return the possessive determine pronoun with an initial cap. Use this where "his", "her", or "their" would go in a sentence.
public func their(possessiveDeterminer: Genderable) -> String {
    return Their(possessiveDeterminer).lowercaseString
}

/// Helper to return the determine pronoun with an initial cap. Use this where "His", "Hers", or "Theirs" would go in a sentence.
public func Theirs(possessive: Genderable) -> String {
    return possessive.genderLexicon.possessivePronoun
}

/// Helper to return the determine pronoun with an initial cap. Use this where "his", "hers", or "theirs" would go in a sentence.
public func theirs(possessive: Genderable) -> String {
    return Theirs(possessive).lowercaseString
}
