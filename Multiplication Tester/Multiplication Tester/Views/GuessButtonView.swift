//
//  GuessButtonView.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/9/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct GuessButtonView: View {
    //@EnvironmentObject var problemModel : ProblemSubModel
    
    @Binding var model : MultiplicationModel
    let color: Color
     let index : Int
    let numString: String
     
     var body: some View {
        Button(action: { self.model.checkAnswer(guess: self.index, problemNum: 0, answerIndex: 0)  }) { 
            Text(numString)
                .padding(7.5)
                .background(color)
                .foregroundColor(.white)
            .cornerRadius(5)
        }
     }
}
