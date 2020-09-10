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
    let multiplicationVM : MultiplicationViewModel
    init(withVM: MultiplicationViewModel) {
        multiplicationVM = withVM
    }
    
    var body: some View {
        HStack {
            ForEach(0..<multiplicationVM.totalQuestions) { i in
                if (self.multiplicationVM.problems[i].gameState == .inactive) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 15, height: 15)
                } else if (self.multiplicationVM.problems[i].gameState == .correct) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 15, height: 15)
                } else if (self.multiplicationVM.problems[i].gameState == .incorrect) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 15, height: 15)
                } 
            }
        }
    }
}
