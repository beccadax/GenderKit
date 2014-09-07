//
//  GenderLexicon+RawRepresentable.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/6/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

private let separator: Character = "|"

extension GenderLexicon: RawRepresentable {
    typealias Raw = String
    public class var SeparatorCharacter: Character {
        return separator
    }
    
    public func toRaw() -> String {
        return join(String(self.dynamicType.SeparatorCharacter), [ gender, lexiconToJSONString() ])
    }
    
    private func lexiconToJSONString() -> String {
        let dict = [ "subject": subjectPronoun, "object": objectPronoun, "possessiveDeterminer": possessiveDeterminerPronoun, "possessive": possessivePronoun ]
        let data = NSJSONSerialization.dataWithJSONObject(dict, options: nil, error: nil)!
        return NSString(data: data, encoding: NSUTF8StringEncoding)
    }
    
    public class func fromRaw(raw: String) -> Self? {
        if let separatorIndex = find(raw, self.SeparatorCharacter) {
            let gender = raw[raw.startIndex ..< separatorIndex]
            let JSONString = raw[separatorIndex.successor() ..< raw.endIndex]
            
            if let lexicon = lexiconFromJSONString(JSONString) {
                return self(gender: gender, subjectPronoun: lexicon.subject, objectPronoun: lexicon.object, possessiveDeterminerPronoun: lexicon.possessiveDeterminer, possessivePronoun: lexicon.possessive)
            }
        }
        
        return nil
    }
    
    private class func lexiconFromJSONString(raw: String) -> (subject: String, object: String, possessiveDeterminer: String, possessive: String)? {
        if let dict = NSJSONSerialization.JSONObjectWithData(raw.dataUsingEncoding(NSUTF8StringEncoding)!, options: nil, error: nil) as? NSDictionary as? [String: String] {
            if let (subject, object, possessiveDeterminer, possessive) = all(dict["subject"], dict["object"], dict["possessiveDeterminer"], dict["possessive"]) {
                return (subject: subject, object: object, possessiveDeterminer: possessiveDeterminer, possessive: possessive)
            }
        }
        return nil
    }
}
