//
//  Sequence+Transform.swift
//  Juggling
//
//  Created by Dan on 9/8/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

extension Sequence where Iterator.Element == Int {
    func joinedDigits() -> Int {
        return Int(reduce("", { $0 + $1.description }))!
    }
}
