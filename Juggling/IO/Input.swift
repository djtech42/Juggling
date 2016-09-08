//
//  Input.swift
//  Juggling
//
//  Created by Dan on 8/29/16.
//  Copyright © 2016 Dan Turner. All rights reserved.
//

import Foundation

enum Input {
    enum Error {
        case invalid(item: String, plural: Bool)
    }
    
    /**
     Keep printing out prompt until user enters a valid response
     */
    static func ensuredValidResponseFrom(prompt: String, basedOnCondition condition: (String) -> Bool, errorMessage: Error) -> String {
        while true {
            print(prompt)
            if let response = readLine(strippingNewline: true), condition(response) {
                return response
            }
            else {
                print(errorMessage.description)
            }
        }
    }
    
    static func ensuredValidResponseFrom<T>(prompt: String, transform: (String) -> T?, errorMessage: Error) -> T {
        while true {
            print(prompt)
            if let response = readLine(strippingNewline: true), let transformedResponse = transform(response) {
                return transformedResponse
            }
            else {
                print(errorMessage.description)
            }
        }
    }
}

protocol CommaSeparatedInputConvertable {
    associatedtype commaSeparatedInputHandleType
    static func commaSeparatedInputHandle(numbers: [Int]) -> commaSeparatedInputHandleType?
}

extension CommaSeparatedInputConvertable {
    static func usingCommaSeparatedIntInput(prompt specifiedPrompt: String) -> commaSeparatedInputHandleType? {
        let inputNumbers = Input.ensuredValidResponseFrom(
            prompt: specifiedPrompt,
            transform: commaSeparatedNumbers,
            errorMessage: .invalid(item: "comma separated numbers", plural: true))
        return commaSeparatedInputHandle(numbers: inputNumbers)
    }
    static func commaSeparatedNumbers(usingInput input: String) -> [Int]? {
        let processedInput = input
            .components(separatedBy: ",")
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            .flatMap({ Int($0) })
        
        guard !processedInput.isEmpty else { return nil }
        return processedInput
    }
}


extension Siteswap: CommaSeparatedInputConvertable {
    static func commaSeparatedInputHandle(numbers: [Int]) -> Siteswap? {
        guard let validSwap = Siteswap(withHeightsFrom: numbers) else {
            print("Swap with heights \(numbers) is not valid.")
            return nil
        }
        return validSwap
    }
}

extension Siteswap.State: CommaSeparatedInputConvertable {
    static func commaSeparatedInputHandle(numbers: [Int]) -> Siteswap.State? {
        return Siteswap.State(with: numbers)
    }
}
