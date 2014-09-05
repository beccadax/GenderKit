//
//  Gender.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/4/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

public enum Gender: Equatable, Printable {
    case Male
    case Female
    case Other (description: String, pronouns: PronounSet)
    
    public var description: String {
        get {
            switch self {
            case .Male:
                return "Male"
            case .Female:
                return "Female"
            case let .Other(description: value, pronouns: _):
                return value
            }
        }
        set {
            switch newValue {
            case Male.description:
                self = .Male
            case Female.description:
                self = .Female
            default:
                self = .Other(description: newValue, pronouns: self.pronouns)
            }
        }
    }
    
    public var pronouns: PronounSet {
        get {
            switch self {
            case .Male:
                return PronounSet.defaultMalePronouns
            case .Female:
                return PronounSet.defaultFemalePronouns
            case let .Other(description: _, pronouns: value):
                return value
            }
        }
        set {
            switch self {
            case .Male, .Female where newValue == pronouns:
                break
            default:
                self = .Other(description: description, pronouns: newValue)
            }
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
        case let .Other(description, pronouns):
            let dict = [ "description": description, "pronouns": pronouns.toRaw() ]
            let JSONData = NSJSONSerialization.dataWithJSONObject(dict, options: nil, error: nil)!
            let JSONString = NSString(data: JSONData, encoding: NSUTF8StringEncoding)
            return "O=\(JSONString)"
        }
    }
    
    public static func fromRaw(raw: String) -> Gender? {
        switch raw {
        case "M":
            return .Male
        case "F":
            return .Female
        case _ where startsWith(raw, "O="):
            let JSONString = raw[ advance(raw.startIndex, 2, raw.endIndex) ..< raw.endIndex ]
            let JSONData = JSONString.dataUsingEncoding(NSUTF8StringEncoding)!
            
            if let dict = NSJSONSerialization.JSONObjectWithData(JSONData, options: nil, error: nil) as? [String: AnyObject] {
                if let (pronounsDict, description) = all(dict["pronouns"] as? NSDictionary, dict["description"] as? NSString) {
                    if let pronouns = PronounSet.fromRaw(pronounsDict) {
                        return .Other(description: description, pronouns: pronouns)
                    }
                }
            }
            fallthrough
        default:
            return nil
        }
    }
}

extension Gender: PronounReferable {}

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
