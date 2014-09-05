//
//  PronounReferable.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/5/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

/// A PronounReferable type is one whose instances can be described by a set of pronouns.
public protocol PronounReferable {
    /// Returns the PronounSet that should be used to describe this instance.
    var pronouns: PronounSet { get }
}

/// Helper to return the subject pronoun with an initial cap. Use this where "He", "She", or "They" would go in a sentence.
public func They(subject: PronounReferable) -> String {
    return subject.pronouns.subject
}

/// Helper to return the subject pronoun lowercased.  Use this where "he", "she", or "they" would go in a sentence.
public func they(subject: PronounReferable) -> String {
    return They(subject).lowercaseString
}

/// Helper to return the object pronoun with an initial cap. Use this where "Him", "Her", or "Them" would go in a sentence.
public func Them(object: PronounReferable) -> String {
    return object.pronouns.object
}

/// Helper to return the object pronoun lowercased. Use this where "him", "her", or "them" would go in a sentence.
public func them(object: PronounReferable) -> String {
    return Them(object).lowercaseString
}

/// Helper to return the possessive determine pronoun with an initial cap. Use this where "His", "Her", or "Their" would go in a sentence.
public func Their(possessiveDeterminer: PronounReferable) -> String {
    return possessiveDeterminer.pronouns.possessiveDeterminer
}

/// Helper to return the possessive determine pronoun with an initial cap. Use this where "his", "her", or "their" would go in a sentence.
public func their(possessiveDeterminer: PronounReferable) -> String {
    return Their(possessiveDeterminer).lowercaseString
}

/// Helper to return the determine pronoun with an initial cap. Use this where "His", "Hers", or "Theirs" would go in a sentence.
public func Theirs(determiner: PronounReferable) -> String {
    return determiner.pronouns.determiner
}

/// Helper to return the determine pronoun with an initial cap. Use this where "his", "hers", or "theirs" would go in a sentence.
public func theirs(determiner: PronounReferable) -> String {
    return Theirs(determiner).lowercaseString
}
