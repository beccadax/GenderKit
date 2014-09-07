//
//  GenderLexicon.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/6/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

// This is currently English-specific.
public class GenderLexicon {
    class var maleLexicon: GenderLexicon {
        return Statics.male
    }
    class var femaleLexicon: GenderLexicon {
        return Statics.female
    }
    class var defaultLexicon: GenderLexicon {
        return Statics.neutral
    }
    
    /// The name of the gender, e.g. "Male", "Female", "Fluid"
    public private(set) var gender: String
    
    /// Subject pronoun—"he" or "she" for male and female genders.
    public private(set) var subjectPronoun: String
    
    /// Object pronoun—"him" or "her" for male and female genders.
    public private(set) var objectPronoun: String
    
    /// Possessive determiner pronoun—"his" or "her" for male and female genders. Generally, these go before a noun.
    public private(set) var possessiveDeterminerPronoun: String
    
    /// Possessive pronoun—"his" or "hers" for male and female genders. Generally, these go after a verb.
    public private(set) var possessivePronoun: String
    
    public required init(gender: String, subjectPronoun: String, objectPronoun: String, possessiveDeterminerPronoun: String, possessivePronoun: String) {
        self.gender = gender
        self.subjectPronoun = subjectPronoun
        self.objectPronoun = objectPronoun
        self.possessiveDeterminerPronoun = possessiveDeterminerPronoun
        self.possessivePronoun = possessivePronoun
    }
    
    public required init(_ lexicon: GenderLexicon) {
        self.gender = lexicon.gender
        self.subjectPronoun = lexicon.subjectPronoun
        self.objectPronoun = lexicon.objectPronoun
        self.possessiveDeterminerPronoun = lexicon.possessiveDeterminerPronoun
        self.possessivePronoun = lexicon.possessivePronoun
    }
    
    private struct Statics {
        static let male = GenderLexicon(gender: "Male", subjectPronoun: "He", objectPronoun: "Him", possessiveDeterminerPronoun: "His", possessivePronoun: "His")
        static let female = GenderLexicon(gender: "Female", subjectPronoun: "She", objectPronoun: "Her", possessiveDeterminerPronoun: "Her", possessivePronoun: "Hers")
        static let neutral = GenderLexicon(gender: "Other", subjectPronoun: "They", objectPronoun: "Them", possessiveDeterminerPronoun: "Their", possessivePronoun: "Theirs")
    }
}

public class MutableGenderLexicon: GenderLexicon {
    override class var maleLexicon: GenderLexicon {
        return MutableGenderLexicon(super.maleLexicon)
    }
    override class var femaleLexicon: GenderLexicon {
        return MutableGenderLexicon(super.femaleLexicon)
    }
    override class var defaultLexicon: GenderLexicon {
        return MutableGenderLexicon(super.defaultLexicon)
    }
    
    /// The name of the gender, e.g. "Male", "Female", "Fluid"
    override public public(set) var gender: String {
        get { return super.gender }
        set { super.gender = newValue }
    }
    
    /// Subject pronoun—"He" or "She" for male and female genders.
    override public public(set) var subjectPronoun: String {
        get { return super.subjectPronoun }
        set { super.subjectPronoun = newValue }
    }
    
    /// Object pronoun—"Him" or "Her" for male and female genders.
    override public public(set) var objectPronoun: String {
        get { return super.objectPronoun }
        set { super.objectPronoun = newValue }
    }
    
    /// Possessive determiner pronoun—"His" or "Her" for male and female genders. Generally, these go before a noun, corresponding to "my".
    override public public(set) var possessiveDeterminerPronoun: String {
        get { return super.possessiveDeterminerPronoun }
        set { super.possessiveDeterminerPronoun = newValue }
    }
    
    /// Possessive pronoun—"His" or "Hers" for male and female genders. Generally, these go after a verb, corresponding to "mine".
    override public public(set) var possessivePronoun: String {
        get { return super.possessivePronoun }
        set { super.possessivePronoun = newValue }
    }
}
