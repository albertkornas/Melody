//
//  GuessButtonView.swift
//  Arithmetic Challenge
//
//  Created by Albert Kornas on 9/9/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct GuessButtonView: View {
    
    @Binding var model : ArithmeticModel
    let color: Color
    let index : Int
    let numString: String
    let ansIndex: Int
     
     var body: some View {
        Button(action: { self.model.checkAnswer(guess: self.index, problemNum: 0, answerIndex: self.ansIndex)  }) {
            Text(numString)
                .padding(7.5)
                .background(color)
                .foregroundColor(.white)
            .cornerRadius(5)
        }.disabled(shouldDisableGuessButton)
     }
    
    var shouldDisableGuessButton : Bool {model.overallState != .playing }
}
