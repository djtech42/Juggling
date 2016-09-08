//
//  Int to Bool.swift
//  Juggling
//
//  Created by Dan on 9/8/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

extension Bool {
    init(from integer: Int) {
        self = integer == 1
    }
}

extension Int {
    init(from booleanValue: Bool) {
        self = booleanValue ? 1 : 0
    }
}
