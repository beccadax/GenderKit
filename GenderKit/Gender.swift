//
//  Gender.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/4/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

public enum Gender: Equatable, Printable {
    static let SeparatorCharacter: Character = "|"
    
    case Male
    case Female
    case Other (GenderLexicon)
    
    init(_ lexicon: GenderLexicon) {
        if lexicon == GenderLexicon.maleLexicon {
            self = .Male
        }
        else if lexicon == GenderLexicon.femaleLexicon {
            self = .Female
        }
        else {
            self = .Other (lexicon)
        }
    }
    
    public var description: String {
        get {
            return genderLexicon.gender
        }
    }
    
    public var genderLexicon: GenderLexicon {
        get {
            switch self {
            case .Male:
                return GenderLexicon.maleLexicon
            case .Female:
                return GenderLexicon.femaleLexicon
            case let .Other(lexicon):
                return lexicon
            }
        }
        set {
            self = Gender(newValue)
        }
    }
}
 
extension Gender: RawRepresentable {
    public func toRaw() -> String {
        switch self {
        case .Male:
            return "M"
        case .Female:
            return "F"
        case let .Other(lexicon):
            return "O" + lexicon.toRaw()
        }
    }
    
    public static func fromRaw(raw: String) -> Gender? {
        switch raw {
        case "M":
            return .Male
        case "F":
            return .Female
        case _ where raw[raw.startIndex] == "O":
            let lexiconStart = raw.startIndex.successor()
            let rawLexicon = raw[lexiconStart ..< raw.endIndex]
            
            if let lexicon = GenderLexicon.fromRaw(rawLexicon) {
                return .Other(lexicon)
            }
            fallthrough
        default:
            return nil
        }
    }
}

public func == (lhs: Gender, rhs: Gender) -> Bool {
    switch (lhs, rhs) {
    case (.Male, .Male):
        return true
    case (.Female, .Female):
        return true
    case (.Other, .Other) where lhs.description == rhs.description:
        return true
    default:
        return false
    }
}
