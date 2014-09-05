//
//  PronounSet.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/4/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

public struct PronounSet: Equatable {
    public var heShe: String
    public var himHer: String
    public var hisHer: String
    public var hisHers: String
    
    public init(heShe: String, himHer: String, hisHer: String, hisHers: String) {
        self.heShe = heShe
        self.himHer = himHer
        self.hisHer = hisHer
        self.hisHers = hisHers
    }
    
    static let defaultMalePronouns = PronounSet(heShe: "He", himHer: "Him", hisHer: "His", hisHers: "His")
    static let defaultFemalePronouns = PronounSet(heShe: "She", himHer: "Her", hisHer: "Her", hisHers: "Hers")
}

extension PronounSet: RawRepresentable {
    public func toRaw() -> NSDictionary {
        return [ "heShe": heShe, "himHer": himHer, "hisHer": hisHer, "hisHers": hisHers ]
    }
    
    public static func fromRaw(raw: NSDictionary) -> PronounSet? {
        if let raw = raw as? [String: String] {
            if let (heShe, himHer, hisHer, hisHers) = all(raw["heShe"], raw["himHer"], raw["hisHer"], raw["hisHers"]) {
                return PronounSet(heShe: heShe, himHer: himHer, hisHer: hisHer, hisHers: hisHers)
            }
        }
        return nil
    }
}

public func == (lhs: PronounSet, rhs: PronounSet) -> Bool {
    return lhs.heShe == rhs.heShe && lhs.himHer == rhs.himHer && lhs.hisHer == rhs.hisHer && lhs.hisHers == rhs.hisHers
}
