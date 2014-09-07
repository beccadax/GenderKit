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
struct InflectableTerm: Inflectable {
    let inflector: (GenderLexicon) -> String
    let index: Int
    
    init(inflector: (GenderLexicon) -> String) {
        self.init(index: 0, inflector: inflector)
    }
    
    init(index: Int, inflector: (GenderLexicon) -> String) {
        self.inflector = inflector
        self.index = index
    }
    
    subscript (i: Int) -> InflectableTerm {
        return InflectableTerm(index: i, inflector: inflector)
    }
    
    func inflectedString(genderLexicons lexicons: [GenderLexicon]) -> String {
        return inflector(lexicons[index])
    }
}
