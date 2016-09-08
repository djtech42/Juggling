//
//  Int+Parity.swift
//  Juggling
//
//  Created by Dan on 8/29/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    var isOdd: Bool {
        return !isEven
    }
}
