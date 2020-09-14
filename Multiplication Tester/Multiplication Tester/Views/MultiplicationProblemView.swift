//
//  MultiplicationProblem.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 8/30/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

//This view displays the number of the problem, as well as the arithemtic problem itself.
import SwiftUI

struct MultiplicationProblemView: View {
    let multiplicationModel : MultiplicationModel
    init(withModel: MultiplicationModel) {
        multiplicationModel = withModel
    }
    var questionNumber : Int {multiplicationModel.currentQuestionCount}
    var body: some View {
         VStack {
            Text("Problem \(questionNumber)")
            Spacer().frame(height:20)
            
                       VStack(alignment: .trailing) {
                        Text(String(multiplicationModel.problems[questionNumber].multiplicand))
                               .font(.headline)
                           HStack {
                               Text("X")
                                   .font(.headline)
                               Text(String(multiplicationModel.problems[questionNumber].multiplier))
                                   .font(.headline)
                           }
                       }
                       Rectangle().frame(width:75, height:3)
                   }
    }
}


