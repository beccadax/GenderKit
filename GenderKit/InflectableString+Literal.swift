//
//  InflectableString+Literal.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/6/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

extension InflectableString: StringLiteralConvertible, StringInterpolationConvertible {
    public static func convertFromExtendedGraphemeClusterLiteral(value: String) -> InflectableString {
        return InflectableString(value)
    }
    
    public static func convertFromStringLiteral(value: String) -> InflectableString {
        return InflectableString(value)
    }
    
    public static func convertFromStringInterpolation(inflectableStrings: InflectableString...) -> InflectableString {
        return reduce(inflectableStrings, InflectableString(), +)
    }
    
    public static func convertFromStringInterpolationSegment<T>(expr: T) -> InflectableString {
        return InflectableString(toString(expr))
    }
    
    public static func convertFromStringInterpolationSegment(expr: Inflectable) -> InflectableString {
        return InflectableString(expr)
    }

    public static func convertFromStringInterpolationSegment<T: Printable>(expr: T) -> InflectableString {
        return InflectableString(expr.description)
    }
}
