//
//  GenderLexicon+Misc.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/6/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

extension GenderLexicon: Equatable {}

public func == (lhs: GenderLexicon, rhs: GenderLexicon) -> Bool {
    return lhs.gender == rhs.gender && lhs.subjectPronoun == rhs.subjectPronoun && lhs.objectPronoun == rhs.objectPronoun && lhs.possessiveDeterminerPronoun == rhs.possessiveDeterminerPronoun && lhs.possessivePronoun == rhs.possessivePronoun
}

extension GenderLexicon: PronounReferable {
    public var genderLexicon: GenderLexicon {
        return self
    }
}
