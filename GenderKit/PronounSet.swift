//
//  PronounSet.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/4/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

public struct PronounSet: Equatable {
    /// Subject pronoun—"he" or "she" for male and female genders.
    public var subject: String
    
    /// Object pronoun—"him" or "her" for male and female genders.
    public var object: String
    
    /// Possessive determiner pronoun—"his" or "her" for male and female genders. Generally, these go before a noun.
    public var possessiveDeterminer: String
    
    /// Possessive pronoun—"his" or "hers" for male and female genders. Generally, these go after a verb.
    public var determiner: String
    
    public init(subject: String, object: String, possessiveDeterminer: String, determiner: String) {
        self.subject = subject
        self.object = object
        self.possessiveDeterminer = possessiveDeterminer
        self.determiner = determiner
    }
    
    static let defaultMalePronouns = PronounSet(subject: "He", object: "Him", possessiveDeterminer: "His", determiner: "His")
    static let defaultFemalePronouns = PronounSet(subject: "She", object: "Her", possessiveDeterminer: "Her", determiner: "Hers")
}

extension PronounSet: RawRepresentable {
    public func toRaw() -> NSDictionary {
        return [ "subject": subject, "object": object, "possessiveDeterminer": possessiveDeterminer, "determiner": determiner ]
    }
    
    public static func fromRaw(raw: NSDictionary) -> PronounSet? {
        if let raw = raw as? [String: String] {
            if let (subject, object, possessiveDeterminer, determiner) = all(raw["subject"], raw["object"], raw["possessiveDeterminer"], raw["determiner"]) {
                return PronounSet(subject: subject, object: object, possessiveDeterminer: possessiveDeterminer, determiner: determiner)
            }
        }
        return nil
    }
}

public func == (lhs: PronounSet, rhs: PronounSet) -> Bool {
    return lhs.subject == rhs.subject && lhs.object == rhs.object && lhs.possessiveDeterminer == rhs.possessiveDeterminer && lhs.determiner == rhs.determiner
}

extension PronounSet: PronounReferable {
    public var pronouns: PronounSet { return self }
}
