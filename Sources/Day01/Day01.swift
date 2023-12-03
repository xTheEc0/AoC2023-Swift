//
//  Day01.swift
//  AoC-Swift-Template
//  Forked from https://github.com/Dean151/AoC-Swift-Template
//
//  Created by Thomas DURAND.
//  Follow me on Twitter @deanatoire
//  Check my computing blog on https://www.thomasdurand.fr/
//

import Foundation

import AoC
import Common


@main
struct Day01: Puzzle {
    // TODO: Start by defining your input/output types :)
    typealias Input = [String]
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
    static var componentsSeparator: InputSeparator {
        .string(string: "\n")
    }
}

// MARK: - PART 1

extension Day01 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            // Example
            assert(expectation: 142, fromRaw: """
                   1abc2
                   pqr3stu8vwx
                   a1b2c3d4e5f
                   treb7uchet
                   """),
            // Edge case with numbers close to one another (modified example from above)
            assert(expectation: 142, fromRaw: """
                   12abc
                   pqr38stuvwx
                   a12bc3d4e5f
                   treb7uchet
                   """)
        ]
    }
    
    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        input.reduce(0, { acc, line in
            let digits = line.map { $0 }.compactMap { Int(String($0)) }
            return acc + digits.first! * 10 + digits.last!
        })
    }
}

// MARK: - PART 2

extension Day01 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 281, fromRaw: """
               two1nine
               eightwothree
               abcone2threexyz
               xtwone3four
               4nineeightseven2
               zoneight234
               7pqrstsixteen
               """),
            assert(expectation: 21, fromRaw: """
                zztwonezztwonezz
                """),
            assert(expectation: 11, fromRaw: """
                z1twonezztwonezz
                """),
            assert(expectation: 31, fromRaw: """
                zztw3onezztw8onezz
                """)
            
        ]
    }
    
    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        input.reduce(0, { acc, line in
            let first = firstNumber(in: line)
            let last = lastNumber(in: line)
            return acc + first * 10 + last
        })
    }
    
    static let search = [
        "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        "1", "2", "3", "4", "5", "6", "7", "8", "9"
    ]
    
    static func firstNumber(in line: String) -> Int {
        var minIndex = Int.max
        var value = 0
        for (strIndex, str) in search.enumerated() {
            if let index = line.indexOf(str), index < minIndex {
                minIndex = index
                value = strIndex + 1
                if index == 0 { break }
            }
        }
        return value > 9 ? value - 9 : value
    }
    
    static func lastNumber(in line: String) -> Int {
        var maxIndex = Int.min
        var value = 0
        for (strIndex, str) in search.enumerated() {
            if let index = line.lastIndexOf(str), index > maxIndex {
                maxIndex = index
                value = strIndex + 1
                if index == line.count - str.count { break }
            }
        }
        return value > 9 ? value - 9 : value
    }
    
    
}

extension String {
    func indexOf(_ substr: String) -> Int? {
        guard let range = self.range(of: substr) else {
            return nil
        }
        
        return distance(from: startIndex, to: range.lowerBound)
    }
    
    func lastIndexOf(_ substr: String) -> Int? {
        guard let range = self.range(of: substr, options: .backwards) else {
            return nil
        }
        
        return distance(from: startIndex, to: range.lowerBound)
    }
}
