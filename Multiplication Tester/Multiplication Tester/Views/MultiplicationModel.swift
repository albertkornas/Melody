//
//  MultiplicationModel.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/4/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

//Think about the basic operations and data that must be exposed to track and modify the state of the game, without considering the user interface.

import Foundation

enum OverallState {
    case notPlaying, playing, finished
}

class MultiplicationModel : ObservableObject {
     var problems: [ProblemSubModel] = [] //Array of problem sub models
    private let questionsPerRound = 1
    var problemCount: Int
    
    init() {
        problemCount = questionsPerRound
        for _ in 0..<problemCount {
            let newProblem = ProblemSubModel.init()
            problems.append(newProblem)
        }
    }
    @Published var overallState : OverallState = .notPlaying
    
    /*var overallState : OverallState {
        for problem in problems {
            if problem.gameState != .inactive {
                return .finished
            }
        }
        return .playing
    }*/
    
    func advanceGameState() {
        switch overallState {
        case .notPlaying:
            overallState = .playing
        case .playing:
            overallState = .finished
        default:
            assert(false, "Cannot advance state")
        }
    }
    
    var nextQuestionText: String {
        switch overallState {
        case .playing:
            return "Next Question"
        case .finished:
            return "Reset"
        case .notPlaying:
            return "-"
        }
    }
    
    var currentQuestionCount = 0
    
    func incrementQuestionCount() {
        currentQuestionCount += 1
    }
    
    func nextQuestion() {
        
    }
    
    func resetGame() {
        currentQuestionCount = 0
    }
    
    func checkAnswer(guess: Int, problemNum: Int, answerIndex: Int) {
        if guess == answerIndex { //correct
            problems[problemNum].gameState = .correct
            currentQuestionCount += 1
            print("Correct")
            print(currentQuestionCount)
        } else { //wrong
            problems[problemNum].gameState = .incorrect
        }
    }
    
    
}
