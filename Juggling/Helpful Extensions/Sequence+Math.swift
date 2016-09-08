//
//  Sequence+Math.swift
//  Juggling
//
//  Created by Dan on 9/8/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

extension Sequence where Iterator.Element == Int {
    func modded(by operand: Int) -> [Int] {
        return map({ $0 % operand })
    }
}
