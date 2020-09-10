//
//  GuessButtonView.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/9/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct GuessButtonView: View {
    @EnvironmentObject var problemModel : ProblemSubModel
    
     let index : Int
    let numString: String
     
     var body: some View {
        Button(action: { self.problemModel.checkAnswer(guess: self.index)  }) {  //TODO: add action to make guess
            Text(numString)
                .padding(7.5)
                .background(Color.blue)
                .foregroundColor(.white)
            .cornerRadius(5)
        }
     }
}

struct ColorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GuessButtonView(index: 0, numString: "0")
    }
}
