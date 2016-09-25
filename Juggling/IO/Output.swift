//
//  Output.swift
//  Juggling
//
//  Created by Dan on 8/31/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

import Foundation

extension Input.Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalid(let item, let plural):
            switch plural {
            case true: return "You did not enter valid \(item)."
            case false: return "You did not enter a valid \(item)."
            }
        }
    }
}

extension BeatState: CustomStringConvertible {
    var description: String {
        switch self {
        case .emptyHand: return "no throw"
        case .holdBall: return "hold ball"
        case .throwBall(let height, let direction): return "throw ball at height \(height) to \(direction)"
        }
    }
}

extension BeatState.Direction: CustomStringConvertible {
    var description: String {
        switch self {
        case .toSameHand: return "same hand"
        case .toOppositeHand: return "opposite hand"
        }
    }
}

extension Siteswap.State: CustomStringConvertible {
    var description: String {
        let representationFormat = "Siteswap.State -> \(representation.map(Int.init))"
        
        if let existingAddedNumber = added {
            return representationFormat + ", added number is \(existingAddedNumber)"
        }
        else {
            return representationFormat
        }
    }
}
