//
//  MultiplicationModel.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/4/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

//Think about the basic operations and data that must be exposed to track and modify the state of the game, without considering the user interface.

import Foundation


struct MultiplicationModel {
    var problems: [ProblemSubModel] = []
    
    private let questionsPerRound = 4
    
    private var currentQuestionCount = 0
    mutating func incrementQuestionCount() {
        currentQuestionCount += 1
    }
    
}
