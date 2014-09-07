//
//  InflectableTerm.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/6/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

/// An InflectableTerm represents a term that should be dynamically inflected 
/// based on appropriate genders. It is intended to look up the term in the 
/// gender lexicon.
public struct InflectableTerm: Inflectable {
    var inflector: (GenderLexicon) -> String
    var index: Int
    
    public init(inflector: (GenderLexicon) -> String) {
        self.init(index: 0, inflector: inflector)
    }
    
    public init(index: Int, inflector: (GenderLexicon) -> String) {
        self.inflector = inflector
        self.index = index
    }
    
    public subscript (i: Int) -> InflectableTerm {
        return InflectableTerm(index: i, inflector: inflector)
    }
    
    public func inflectedString(genderLexicons lexicons: [GenderLexicon]) -> String {
        return inflector(lexicons[index])
    }
}

public let They = InflectableTerm { $0.subjectPronoun }
public let they = InflectableTerm { $0.subjectPronoun.lowercaseString }

public let Them = InflectableTerm { $0.objectPronoun }
public let them = InflectableTerm { $0.objectPronoun.lowercaseString }

public let Their = InflectableTerm { $0.possessiveDeterminerPronoun }
public let their = InflectableTerm { $0.possessiveDeterminerPronoun.lowercaseString }

public let Theirs = InflectableTerm { $0.possessivePronoun }
public let theirs = InflectableTerm { $0.possessivePronoun.lowercaseString }
