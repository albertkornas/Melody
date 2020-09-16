//
//  ProblemStatus.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 8/30/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

//This view shows the progress of the user, and how many questions they have answered as well as whether they answered correctly or incorrectly

import SwiftUI

struct ProblemStatusView: View {
    var arithmeticModel : ArithmeticModel
    var totalQuestions : Int {arithmeticModel.questionsPerRound}
    var problems : [ ProblemSubModel] {arithmeticModel.problems}
    let questionNumber : Int

    
    var body: some View {
                    Circle()
                        .fill(Color.background(for: self.problems[questionNumber].gameState))
                        .frame(width: 15, height: 15)
    }
}
