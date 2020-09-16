//
//  ProblemSubModel.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/4/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import Foundation

enum ProblemState {
    case inactive, active, correct, incorrect
}

struct ProblemSubModel {
    


    let answerChoices = 4 //The number of answer choices available to the user
    init(mode: ArithmeticModel.Mode, difficulty: ArithmeticModel.Difficulty) {
        var arithmeticRange : Range = 0..<0
        
        switch difficulty {
        case .easy:
            arithmeticRange = 1..<11
        case .medium:
            if (mode == .addition) {
                arithmeticRange = 7..<100
            } else {
                arithmeticRange = 7..<16
            }
        case .hard:
            if (mode == .addition) {
                arithmeticRange = 50..<1000
            } else {
                arithmeticRange = 12..<31
            }
        }
        
        firstArithmeticNumber = Int.random(in:arithmeticRange)
        secondArithmeticNumber = Int.random(in:arithmeticRange)
        
        if (mode == .multiplication) {
            answer = firstArithmeticNumber*secondArithmeticNumber
        } else {
            answer = firstArithmeticNumber+secondArithmeticNumber
        }
        //possibleAnswers.append(answer)
        answerIndex = Int.random(in:0..<answerChoices)
        var index = 0
        while (possibleAnswers.count < answerChoices) {
            if (index == answerIndex && !possibleAnswers.contains(answer)) {
                possibleAnswers.append(answer)
            } else {
                let randomChoice = Int.random(in:answer-5..<answer+6)
                if (!possibleAnswers.contains(randomChoice) && randomChoice > 0) {
                    possibleAnswers.append(randomChoice)
                }
            }
            index += 1
        }
        
        for (index, value) in possibleAnswers.enumerated()
        {
            if value == answer {
                answerIndex = index
            }
        }

    }
    var gameState : ProblemState = .inactive
    
    var firstArithmeticNumber = 0
    var secondArithmeticNumber = 0
    var answer = 0
    var possibleAnswers : [Int] = []
    var answerIndex = 0
    
    var nextQuestionText: String {
        switch gameState {
        case .correct:
            return "Correct!"
        case .incorrect:
            return "Incorrect! The correct answer was \(answer)."
        default:
            return ""
        }
    }
    
    


    
}
