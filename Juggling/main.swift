//
//  main.swift
//  Juggling
//
//  Created by Dan on 8/29/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

import Foundation

/**
 Example Code
 */

if let validSwap = Siteswap.usingCommaSeparatedIntInput(prompt: "Enter pattern: ") {
    print(validSwap.states)
}

if let validState = Siteswap.State.usingCommaSeparatedIntInput(prompt: "Enter state representation: ") {
    print(validState)
}
