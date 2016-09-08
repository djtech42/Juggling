//
//  Array+Shift.swift
//  Juggling
//
//  Created by Dan on 8/29/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

extension Array {
    func shiftRight(amount: Int = 1) -> [Element] {
        var mutableAmount = amount
        precondition(-count...count ~= amount, "Shift amount out of bounds")
        if amount < 0 { mutableAmount += count }  // this needs to be >= 0
        return Array(self[amount ..< count] + self[0 ..< amount])
    }
    
    mutating func shiftRightInPlace(amount: Int = 1) {
        self = shiftRight(amount: amount)
    }
}
