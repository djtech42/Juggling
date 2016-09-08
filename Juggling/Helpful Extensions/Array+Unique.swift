//
//  Array+Unique.swift
//  Juggling
//
//  Created by Dan on 9/8/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

extension Array where Element: Hashable {
    var areAllUnique: Bool {
        return Set(self).count == count
    }
}
