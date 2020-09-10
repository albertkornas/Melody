//
//  MultiplicationViewModel.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/4/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import Foundation

class MultiplicationViewModel: ObservableObject {
    @Published var multiplicationModel = MultiplicationModel() //with: x problems per round
    @Published var problemModel = ProblemSubModel()
    //Intents from View
    //var multiplicand : String {MultiplicationModel}
    var questionNumber : Int {multiplicationModel.currentQuestionCount}
    var totalQuestions : Int {multiplicationModel.problemCount}
    var problems: [ProblemSubModel] {multiplicationModel.problems}
    var answerChoices : Int {problemModel.answerChoices}
    var gameState : State { problemModel.gameState }
}
