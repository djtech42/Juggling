//
//  BeatState.swift
//  Juggling
//
//  Created by Dan on 8/29/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

import Foundation

enum BeatState: RawRepresentable, Hashable {
    enum Direction {
        case toSameHand
        case toOppositeHand
    }
    case throwBall(height: Int, Direction)
    case holdBall
    case emptyHand
    
    init(rawValue: Int) {
        switch rawValue {
        case 2: self = .holdBall
        case 0: self = .emptyHand
        default: self = .throwBall(height: rawValue, rawValue.isEven ? .toSameHand : .toOppositeHand)
        }
    }
    var rawValue: Int {
        switch self {
        case .throwBall(let height, _): return height
        case .holdBall: return 2
        case .emptyHand: return 0
        }
    }
    
    var hashValue: Int {
        return rawValue
    }
    
    static func ==(lhs: BeatState, rhs: BeatState) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
