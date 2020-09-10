//
//  MultiplicationModel.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/4/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

//Think about the basic operations and data that must be exposed to track and modify the state of the game, without considering the user interface.

import Foundation

class MultiplicationModel {
    var problems: [ProblemSubModel] = [] //Array of problem sub models
    private let questionsPerRound = 1
    var problemCount: Int
    
    init() {
        problemCount = questionsPerRound
        for _ in 0..<problemCount {
            let newProblem = ProblemSubModel.init()
            problems.append(newProblem)
        }
        print(problems.count)
    }
    
    @Published var currentQuestionCount = 0
    
    func incrementQuestionCount() {
        currentQuestionCount += 1
    }
    
    func resetGame() {
        

    }
    
    
}
