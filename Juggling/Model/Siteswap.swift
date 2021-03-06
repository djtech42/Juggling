//
//  Siteswap.swift
//  Juggling
//
//  Created by Dan on 8/29/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

import Foundation

func numberOfPossibleSiteswaps(ofLength length: Int, withNumberOfBalls numberOfBalls: Int) -> Int {
    return (numberOfBalls + 1) ** length - numberOfBalls ** length
}

struct Siteswap: Hashable {
    var heights: [Int]
    
    
    var length: Int {
        return heights.count
    }
    
    var beatStates: [BeatState] {
        return heights.map(BeatState.init)
    }
    
    var landingTimes: [Int] {
        return heights.enumerated().map({ $0 + $1 })
    }
    
    func landingTimeAt(beat: Int) -> Int {
        return beat + heights[beat % heights.count]
    }
    
    /**
     Averaging Theorem
     */
    var numberOfBalls: Int {
        return heights.reduce(0, +) / length
    }
    
    var derivedSwaps: [Siteswap] {
        var shifts: [Siteswap] = []
        var currentShift = heights.shiftRight(amount: 1)
        repeat {
            guard let validSwap = Siteswap(withHeightsFrom: currentShift) else { break }
            shifts.append(validSwap)
            currentShift = currentShift.shiftRight(amount: 1)
        } while currentShift != heights
        
        return shifts
    }
    
    var initialState: State {
        return State(from: self)
        
    }
    
    var derivedStates: [State] {
        return derivedSwaps.map(State.init)
    }
    
    var states: [State] {
        return [initialState] + derivedStates
    }
    
    
    var hashValue: Int {
        return heights.joinedDigits()
    }
    
    
    init?(withHeightsFrom heights: [Int]) {
        self.heights = heights
        
        guard !heights.isEmpty && landingTimes.modded(by: length).areAllUnique else { return nil }
    }
    
    
    static func ==(lhs: Siteswap, rhs: Siteswap) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
    struct State: Hashable {
        var representation: [Bool]
        var added: Int?
        
        
        var integerRepresentation: [Int] {
            return representation.map({ Int(from: $0) })
        }
        var numberOfBalls: Int {
            return integerRepresentation.reduce(0, +)
        }
        
        func numberOfPossibleSiteswaps(ofLength swapLength: Int) -> Int {
            var tempRepresentation = representation
            if swapLength > length {
                for _ in length...swapLength {
                    tempRepresentation.append(false)
                }
            }
            
            for i in swapLength..<tempRepresentation.count {
                if tempRepresentation[i] && tempRepresentation[i - swapLength] != tempRepresentation[i] {
                    return 0
                }
            }
            
            var currentMultiplier = 1
            var product = 1
            var increment = true
            
            for j in 0..<swapLength - 1 {
                if increment {
                    currentMultiplier += 1
                }
                product *= currentMultiplier
                increment = tempRepresentation[j + 1]
            }
            
            return product
        }
        
        var length: Int {
            return representation.count
        }
        
        
        var hashValue: Int {
            return integerRepresentation.joinedDigits()
        }
        
        
        init?(with representation: [Int]) {
            guard representation.onlyContainsElements(in: Set([0, 1])) else { return nil }
            
            self.init(with: representation.map(Bool.init))
        }
        
        init(with representation: [Bool]) {
            self.representation = representation
        }
        
        init?(with representation: [Int], andAddedNumber added: Int) {
            self.init(with: representation)
            self.added = added
        }
        
        init(with representation: [Bool], andAddedNumber added: Int) {
            self.init(with: representation)
            self.added = added
        }
        
        init(from swap: Siteswap) {
            var ballNumbers: [Int] = []
            swap.heights.enumerated().map({ index, height in index + height }).forEach({ height in
                var number = height
                repeat {
                    number = number - swap.heights.count
                    if number >= 0 {
                        ballNumbers.append(number)
                    }
                } while number - swap.heights.count >= 0
            })
            
            let blankState = Array(repeating: 0, count: ballNumbers.max()! + 1)
            representation = blankState.enumerated().map({ index, _ in ballNumbers.contains(index) })
            self.added = swap.heights.last!
        }
        
        
        static func ==(lhs: State, rhs: State) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }
}
