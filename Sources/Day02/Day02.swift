//
//  Day02.swift
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

struct Game : Parsable {
    let id: Int
    let sets: [Set]
    
    struct Set {
        var red = 0
        var green = 0
        var blue = 0
        
        init(red: Int, green: Int, blue: Int) {
            self.red = red
            self.green = green
            self.blue = blue
        }
        
        init(_ string: String) {
            for color in string.components(separatedBy: ",") {
                let s = color.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: " ")
                let value = Int(s[0])!
                switch s[1] {
                case "red" : self.red = value
                case "green": self.green = value
                case "blue": self.blue = value
                default: fatalError()
                }
            }
        }
        
        var power: Int {
            max(red, 1) * max(green, 1) * max(blue, 1)
        }
        
        var isPossible: Bool {
            red <= 12 && green <= 13 && blue <= 14
        }
        
    }
    static func parse(raw: String) throws -> Game {
        let parts = raw.components(separatedBy: ": ")
        let mID = Int(String(parts[0].dropFirst(5)))!
        let mSets = parts[1].components(separatedBy: ";").map { Set($0) }
        return .init(id: mID, sets: mSets)
    }
    
    var isPossible: Bool {
        sets.allSatisfy { $0.isPossible }
    }
    
    var minimumSet: Set {
        Set(
            red: sets.max(of: \.red) ?? 0,
            green: sets.max(of: \.green) ?? 0,
            blue: sets.max(of: \.blue) ?? 0
        )
    }
}

extension Sequence {
    public func max<Value: Comparable>(of keyPath: KeyPath<Element, Value>) -> Value? {
        let element = self.max(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
        return element?[keyPath: keyPath]
    }
}

@main
struct Day02: Puzzle {
    typealias Input = [Game]
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
    
    static var componentsSeparator: InputSeparator {
        .string(string: "\n")
    }
}

// MARK: - PART 1

extension Day02 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 8, fromRaw: """
            Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
            Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
            Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
            Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
            Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
            """)
        ]
    }
    
    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        // TODO: Solve part 1 :)
        let answer = input.filter { $0.isPossible }.map {$0.id }.reduce(0, +)
        return answer
    }
}

// MARK: - PART 2

extension Day02 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 2286, fromRaw: """
            Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
            Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
            Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
            Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
            Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
            """)
        ]
    }
    
    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        // TODO: Solve part 2 :)
        let answer = input.map { $0.minimumSet.power }.reduce(0, +)
        return answer
    }
}
