//
//  SiteswapTests.swift
//  JugglingTests
//
//  Created by Dan on 9/1/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

import XCTest
@testable import Juggling

class SiteswapTests: XCTestCase {
    func testValidSwap() {
        var swap = Siteswap(withHeightsFrom: [9, 1, 5, 1])
        XCTAssertNotNil(swap)
        
        swap = Siteswap(withHeightsFrom: [7, 3, 7, 3])
        XCTAssertNotNil(swap)
    }
    
    func testInvalidSwap() {
        var swap = Siteswap(withHeightsFrom: [2, 7, 4, 5])
        XCTAssertNil(swap)
        
        swap = Siteswap(withHeightsFrom: [7, 2, 10, 1, 0, 6])
        XCTAssertNil(swap)
    }
    
    func testJoinHeights() {
        let swap = Siteswap(withHeightsFrom: [9, 1, 5, 1])
        XCTAssertEqual(swap!.hashValue, 9151)
    }
    
    func testBeatStates() {
        var swap = Siteswap(withHeightsFrom: [9, 1, 5, 1])
        XCTAssertEqual(swap!.beatStates, [BeatState.throwBall(height: 9, .toOppositeHand), BeatState.throwBall(height: 1, .toOppositeHand), BeatState.throwBall(height: 5, .toOppositeHand), BeatState.throwBall(height: 1, .toOppositeHand)])
        
        swap = Siteswap(withHeightsFrom: [5, 2, 4, 6, 8])
        XCTAssertEqual(swap!.beatStates, [BeatState.throwBall(height: 5, .toOppositeHand), BeatState.throwBall(height: 2, .toSameHand), BeatState.throwBall(height: 4, .toSameHand), BeatState.throwBall(height: 6, .toSameHand), BeatState.throwBall(height: 8, .toSameHand)])
        
    }
    
    func testSwapLength() {
        var swap = Siteswap(withHeightsFrom: [9, 1, 5, 1])
        XCTAssertEqual(swap!.length, 4)
        
        swap = Siteswap(withHeightsFrom: [5, 2, 4, 6, 8])
        XCTAssertEqual(swap!.length, 5)
    }
    
    func testNumberOfBalls() {
        var swap = Siteswap(withHeightsFrom: [9, 1, 5, 1])
        XCTAssertEqual(swap!.numberOfBalls, 4)
        
        swap = Siteswap(withHeightsFrom: [5, 2, 4, 6, 8])
        XCTAssertEqual(swap!.numberOfBalls, 5)
    }
    
    func testNumberOfPossibleSiteswapsForNumberOfBalls1() {
        XCTAssertEqual(numberOfPossibleSiteswaps(ofLength: 5, withNumberOfBalls: 3), 781)
    }

    func testNumberOfPossibleSiteswapsForNumberOfBalls2() {
        XCTAssertEqual(numberOfPossibleSiteswaps(ofLength: 3, withNumberOfBalls: 5), 91)
    }
    
    func testNumberOfPossibleSiteswapsForNumberOfBalls3() {
        XCTAssertEqual(numberOfPossibleSiteswaps(ofLength: 10, withNumberOfBalls: 2), 58025)
    }
    
    func testStateNumberOfBalls() {
        let state = Siteswap.State(with: [1, 0, 0, 1, 1, 0, 1])
        XCTAssertEqual(state!.numberOfBalls, 4)
    }
    
    func testStateNumberOfSiteswaps1() {
        let state = Siteswap.State(with: [1, 1, 0, 1, 0, 1])
        XCTAssertEqual(state!.numberOfPossibleSiteswaps(ofLength: 3), 0)
    }
    
    func testStateNumberOfSiteswaps2() {
        let state = Siteswap.State(with: [1, 1, 0, 1, 0, 1])
        XCTAssertEqual(state!.numberOfPossibleSiteswaps(ofLength: 5), 72)
    }
    
    func testStateNumberOfSiteswaps3() {
        let state = Siteswap.State(with: [1, 1, 1, 0, 1, 1])
        XCTAssertEqual(state!.numberOfPossibleSiteswaps(ofLength: 5), 96)
    }
    
    func testStateNumberOfSiteswaps4() {
        let state = Siteswap.State(with: [1, 1, 1, 0, 1, 0, 1, 0, 1])
        XCTAssertEqual(state!.numberOfPossibleSiteswaps(ofLength: 8), 14400)
    }
    
    func testStateNumberOfSiteswaps5() {
        let state = Siteswap.State(with: [1, 1, 1, 1, 1, 0, 1])
        XCTAssertEqual(state?.numberOfPossibleSiteswaps(ofLength: 10), 1481760)
    }
    
    func testLandingTimes() {
        let swap = Siteswap(withHeightsFrom: [9, 1, 5, 1])
        let expectedResults = [9, 2, 7, 4]
        XCTAssertEqual(swap!.landingTimes, expectedResults)
        
        let expectedBeatResults = [9, 2, 7, 4, 13, 6, 11, 8]
        expectedBeatResults.enumerated().forEach({
            XCTAssertEqual(swap!.landingTimeAt(beat: $0), $1)
        })
    }
}
