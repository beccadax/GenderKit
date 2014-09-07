//
//  InflectableString.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/6/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

public struct InflectableString: Inflectable, Printable {
    private var segments: [Inflectable] = []
    
    public init() {}
    
    public init(_ segments: Inflectable...) {
        self.init(segments)
    }
    
    public init(_ segments: [Inflectable]) {
        self.segments = segments
    }
    
    public func inflectedSegments(genderLexicons lexicons: [GenderLexicon]) -> [String] {
        return segments.map { $0.inflectedString(genderLexicons: lexicons) }
    }
    
    public func lazyInflectedSegments(genderLexicons lexicons: [GenderLexicon]) -> LazyRandomAccessCollection<MapCollectionView<[Inflectable], String>> {
        return lazy(segments).map { $0.inflectedString(genderLexicons: lexicons) }
    }
    
    public func inflectedString(genderLexicons lexicons: [GenderLexicon]) -> String {
        return reduce(lazyInflectedSegments(genderLexicons: lexicons), "", +)
    }
    
    public var description: String {
        return reduce(segments.map(toString), "", +)
    }
}

extension InflectableString: ExtensibleCollectionType {
    public func generate() -> IndexingGenerator<InflectableString> {
        return IndexingGenerator(self)
    }
    
    public var startIndex: Int {
        return segments.startIndex
    }
    public var endIndex: Int {
        return segments.endIndex
    }
    public subscript (i: Int) -> Inflectable {
        get {
            return segments[i]
        }
        set {
            segments[i] = newValue
        }
    }
    
    public mutating func reserveCapacity(n: Int) {
        segments.reserveCapacity(n)
    }
    
    public mutating func append(newElement: Inflectable) {
        segments.append(newElement)
    }
    
    public mutating func extend<S : SequenceType where S.Generator.Element == Inflectable>(seq: S) {
        segments.extend(seq)
    }
}
