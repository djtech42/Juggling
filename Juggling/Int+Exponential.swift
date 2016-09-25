//
//  Int+Exponential.swift
//  Juggling
//
//  Created by Dan on 9/25/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

import Foundation

precedencegroup ExponentPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentPrecedence
extension Int {
    static func **(lhs: Int, rhs: Int) -> Int {
        return Int(pow(Double(lhs), Double(rhs)))
    }
}
