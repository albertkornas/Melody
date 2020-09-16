//
//  ContentView.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 8/30/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.pink.edgesIgnoringSafeArea(.all)
                VStack(alignment:.center, spacing: 50) {
                    Text("Arithmetic Challenge")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination:GameRootView()) {
                        Text("Start Game")
                            .foregroundColor(.white)
                            .font(.system(size:20, design: .rounded))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.orange))
                            
                    }
                }
            }
        }
    }
}

struct GameRootView: View {
    //@ObservedObject var multiplicationViewModel = MultiplicationViewModel()
    @State private var arithmeticModel = ArithmeticModel()
    
    
    var questionNumber : Int {arithmeticModel.currentQuestionCount}
    var totalQuestions : Int {arithmeticModel.questionsPerRound}

    
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 25) {

                HeaderView(arithmeticModel: arithmeticModel)

                
                //Show the x # of circles displaying status of problems (correct, incorrect, or N/A), as well as text to show user
                VStack(spacing:10) {
                    HStack {
                ForEach(0..<totalQuestions, id: \.self) { i in
                    ProblemStatusView(arithmeticModel: self.arithmeticModel, questionNumber: i)
                    }
                    }
                Text("You've answered \(arithmeticModel.correctAnswers)/\(totalQuestions) questions correctly")
                    .font(.caption)

                }
                
                //Show the randomly generated multiplication problem
                MultiplicationProblemView(withModel: arithmeticModel)

                
                AnswerButtons(arithmeticModel: $arithmeticModel)
                

                Button(action: {
                    self.arithmeticModel.nextQuestion()
                }) {
                    
                    Text(self.arithmeticModel.nextQuestionText)
                        .padding(7.5)
                    .cornerRadius(5)
                    .disabled(true)
                }
                
                PreferenceButtonView(questionsPerRound: self.$arithmeticModel.questionsPerRound, difficultyIndex: self.$arithmeticModel.difficultyIndex, arithmeticModel: self.arithmeticModel, modeIndex: self.$arithmeticModel.modeIndex)
                
                
                

            }
        }
    .navigationBarBackButtonHidden(true)
    .navigationBarHidden(true)
    .navigationBarTitle("")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}


struct AnswerButtons: View { //This view contains the 4 guess buttons
    @Binding var arithmeticModel : ArithmeticModel
    var questionNumber : Int {arithmeticModel.currentQuestionCount}
    var body: some View {
        VStack(spacing: 20.0) {
        HStack {
            ForEach(0..<(self.arithmeticModel.problems[0].answerChoices)) { i in
                GuessButtonView(model: self.$arithmeticModel, color:Color.blue, index: i, numString: String(self.arithmeticModel.problems[self.questionNumber].possibleAnswers[i]), ansIndex: self.arithmeticModel.problems[self.questionNumber].answerIndex)
            }
        }
                            Text(self.arithmeticModel.problems[self.questionNumber].nextQuestionText)
        }
    }
}
