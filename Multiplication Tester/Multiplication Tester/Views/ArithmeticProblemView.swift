//
//  MultiplicationProblem.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 8/30/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

//This view displays the number of the problem, as well as the arithemtic problem itself.
import SwiftUI

struct ArithmeticProblemView: View {
    let arithmeticModel : ArithmeticModel
    init(withModel: ArithmeticModel) {
        arithmeticModel = withModel
    }
    var questionNumber : Int {arithmeticModel.currentQuestionCount}
    var body: some View {
        VStack {
            Text("Problem \(questionNumber+1)")
            
            VStack(alignment: .trailing) {
                        Text(String(arithmeticModel.problems[questionNumber].firstArithmeticNumber))
                               .font(.headline)
                           HStack {
                            Text(arithmeticModel.operationSymbol)
                                   .font(.headline)
                               Text(String(arithmeticModel.problems[questionNumber].secondArithmeticNumber))
                                   .font(.headline)
                           }
                       }
                       Rectangle().frame(width:75, height:3)
                   }
    }
}


