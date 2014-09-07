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
    public var possessive: String
    
    public init(subject: String, object: String, possessiveDeterminer: String, possessive: String) {
        self.subject = subject
        self.object = object
        self.possessiveDeterminer = possessiveDeterminer
        self.possessive = possessive
    }
    
    static let defaultMalePronouns = PronounSet(subject: "He", object: "Him", possessiveDeterminer: "His", possessive: "His")
    static let defaultFemalePronouns = PronounSet(subject: "She", object: "Her", possessiveDeterminer: "Her", possessive: "Hers")
}

extension PronounSet: RawRepresentable {
    public func toRaw() -> String {
        let dict = [ "subject": subject, "object": object, "possessiveDeterminer": possessiveDeterminer, "possessive": possessive ]
        let data = NSJSONSerialization.dataWithJSONObject(dict, options: nil, error: nil)!
        return NSString(data: data, encoding: NSUTF8StringEncoding)
    }
    
    public static func fromRaw(raw: String) -> PronounSet? {
        if let dict = NSJSONSerialization.JSONObjectWithData(raw.dataUsingEncoding(NSUTF8StringEncoding)!, options: nil, error: nil) as? NSDictionary as? [String: String] {
            if let (subject, object, possessiveDeterminer, possessive) = all(dict["subject"], dict["object"], dict["possessiveDeterminer"], dict["possessive"]) {
                return PronounSet(subject: subject, object: object, possessiveDeterminer: possessiveDeterminer, possessive: possessive)
            }
        }
        return nil
    }
}

public func == (lhs: PronounSet, rhs: PronounSet) -> Bool {
    return lhs.subject == rhs.subject && lhs.object == rhs.object && lhs.possessiveDeterminer == rhs.possessiveDeterminer && lhs.possessive == rhs.possessive
}
