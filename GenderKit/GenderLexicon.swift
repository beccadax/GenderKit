//
//  GenderLexicon.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/6/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

// This is currently English-specific.
public struct GenderLexicon {
    static var maleLexicon = GenderLexicon(gender: "Male", subjectPronoun: "He", objectPronoun: "Him", possessiveDeterminerPronoun: "His", possessivePronoun: "His")
    static var femaleLexicon = GenderLexicon(gender: "Female", subjectPronoun: "She", objectPronoun: "Her", possessiveDeterminerPronoun: "Her", possessivePronoun: "Hers")
    static var defaultLexicon = GenderLexicon(gender: "Other", subjectPronoun: "They", objectPronoun: "Them", possessiveDeterminerPronoun: "Their", possessivePronoun: "Theirs")
    
    /// The name of the gender, e.g. "Male", "Female", "Fluid"
    public var gender: String
    
    /// Subject pronoun—"he" or "she" for male and female genders.
    public var subjectPronoun: String
    
    /// Object pronoun—"him" or "her" for male and female genders.
    public var objectPronoun: String
    
    /// Possessive determiner pronoun—"his" or "her" for male and female genders. Generally, these go before a noun.
    public var possessiveDeterminerPronoun: String
    
    /// Possessive pronoun—"his" or "hers" for male and female genders. Generally, these go after a verb.
    public var possessivePronoun: String
    
    public init(gender: String, subjectPronoun: String, objectPronoun: String, possessiveDeterminerPronoun: String, possessivePronoun: String) {
        self.gender = gender
        self.subjectPronoun = subjectPronoun
        self.objectPronoun = objectPronoun
        self.possessiveDeterminerPronoun = possessiveDeterminerPronoun
        self.possessivePronoun = possessivePronoun
    }
}
