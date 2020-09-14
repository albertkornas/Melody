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
    //@EnvironmentObject var problemModel : ProblemSubModel
    
    let multiplicationModel : MultiplicationModel
    init(withModel: MultiplicationModel) {
        multiplicationModel = withModel
    }
    var totalQuestions : Int {multiplicationModel.problemCount}
    var problems: [ProblemSubModel] {multiplicationModel.problems}
    var body: some View {
        HStack {
            ForEach(0..<totalQuestions) { i in
                if (self.problems[i].gameState == .inactive) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 15, height: 15)
                } else if (self.problems[i].gameState == .correct) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 15, height: 15)
                } else if (self.problems[i].gameState == .incorrect) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 15, height: 15)
                } 
            }
        }
    }
}
