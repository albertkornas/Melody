//
//  ArithmeticModel.swift
//  ArithmeticChallenge
//
//  Created by Albert Kornas on 9/4/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

//Think about the basic operations and data that must be exposed to track and modify the state of the game, without considering the user interface.

import Foundation

enum OverallState {
    case playing, answered, finished
}



struct ArithmeticModel {
     var problems: [ProblemSubModel] = [] //Array of problem sub models
    var difficultyIndex : Difficulty = .easy {
        didSet {
            resetGame()
        }
    }
    var modeIndex : Mode = .multiplication {
        didSet {
            resetGame()
        }
    }
    var questionsPerRound = 4 {
        didSet {
            resetGame()
        }
    }
    
    enum Difficulty : String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        
        case easy, medium, hard
    }

    enum Mode: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        
        case addition, multiplication
    }
    
    init() {
        for _ in 0..<questionsPerRound {
            let newProblem = ProblemSubModel.init(mode: .multiplication, difficulty: .easy)
            problems.append(newProblem)
        }
    }
    var overallState : OverallState = .playing
    var correctAnswers = 0
    
    mutating func advanceGameState() {
        switch overallState {
        case .playing:
             if (currentQuestionCount+1 >= questionsPerRound) {
                overallState = .finished
             } else {
                overallState = .answered
             }
        case .answered:
                overallState = .playing
            
        default:
            overallState = .finished
        }
    }
    
    var nextQuestionText: String {
        switch overallState {
        case .answered:
                return "Next Question"
        case .finished:
            return "Reset"
        case .playing:
            return ""
        }
    }
    
    var operationSymbol: String {
        switch modeIndex {
        case .addition:
            return "+"
        case .multiplication:
            return "X"
        }
    }
    
    
    var currentQuestionCount = 0
    
    
    mutating func nextQuestion() {
        if (currentQuestionCount < questionsPerRound-1) {
            advanceGameState()
            currentQuestionCount += 1
        } else if (overallState == .finished){
            resetGame()
        }
    }
    
    mutating func resetGame() {
        currentQuestionCount = 0
        correctAnswers = 0
        overallState = .playing
        problems.removeAll()
        for _ in 0..<questionsPerRound {
            let newProblem = ProblemSubModel.init(mode: modeIndex, difficulty: difficultyIndex)
            problems.append(newProblem)
        }
    }
    
    mutating func checkAnswer(guess: Int, problemNum: Int, answerIndex: Int) {
        if guess == answerIndex { //correct
            problems[currentQuestionCount].gameState = .correct
            correctAnswers += 1
        } else { //wrong
            problems[currentQuestionCount].gameState = .incorrect
        }
        advanceGameState()
    }
    
    
}
