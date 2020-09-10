//
//  ProblemSubModel.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/4/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import Foundation

enum State {
    case inactive, active, correct, incorrect
}

class ProblemSubModel : ObservableObject {
    let lowMultiplicationNumber = 1 //The lower bound of the multiplicand/multiplier (inclusive)
    let highMultiplicationNumber = 16 //The higher bound of the multiplicand/multiplier (exclusive)
    let answerChoices = 4 //The number of answer choices available to the user
    init() {
        multiplicand = Int.random(in:lowMultiplicationNumber..<highMultiplicationNumber)
        multiplier = Int.random(in:lowMultiplicationNumber..<highMultiplicationNumber)
        answer = multiplier*multiplicand
        possibleAnswers.append(answer)
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
    var gameState : State = .inactive
    
    var multiplicand = 0
    var multiplier = 0
    var answer = 0
    var possibleAnswers : [Int] = []
    var answerIndex = 0

    
}
