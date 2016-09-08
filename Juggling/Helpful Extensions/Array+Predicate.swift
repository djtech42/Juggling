//
//  Array+Predicate.swift
//  Juggling
//
//  Created by Dan on 9/8/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

extension Array {
    func onlyContainsElements(matchingPredicate predicate: (Element) -> Bool) -> Bool {
        return filter(predicate).count == count
    }
}

extension Array where Element: Hashable {
    func onlyContainsElements(in set: Set<Element>) -> Bool {
        return filter({ set.contains($0) }).count == count
    }
}
