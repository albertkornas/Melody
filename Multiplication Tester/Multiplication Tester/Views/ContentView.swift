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
                    Text("Multiplication Tester")
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
    @ObservedObject var multiplicationViewModel = MultiplicationViewModel()
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Multiplication Exercises")
                    .font(.largeTitle)
                Spacer().frame(height:60)
                
                //Show the 5 circles displaying status of problems (correct, incorrect, or N/A)
                ProblemStatusView(withVM: multiplicationViewModel)
                Text("You've answered \(multiplicationViewModel.questionNumber)/\(multiplicationViewModel.totalQuestions) questions correctly")
                    .font(.caption)
                Spacer().frame(height:50)
                
                
                //Show the randomly generated multiplication problem
                MultiplicationProblemView(withVM: multiplicationViewModel)
                Spacer().frame(height: 30)
                
                AnswerButtons(withVM: multiplicationViewModel)
                Spacer().frame(height:30)
                Button(action: {
                    self.multiplicationViewModel.multiplicationModel.nextQuestion()
                }) {
                    
                    Text(self.multiplicationViewModel.multiplicationModel.nextQuestionText)
                        .padding(7.5)
                    .cornerRadius(5)
                    .disabled(true)
                }
                
                

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


struct AnswerButtons: View {
    let multiplicationVM : MultiplicationViewModel
    init(withVM: MultiplicationViewModel) {
        multiplicationVM = withVM
    }
    
    
    var body: some View {
        HStack {
            ForEach(0..<(self.multiplicationVM.problems[0].answerChoices)) { i in
                GuessButtonView(color:Color.blue, index: i, numString: String(self.multiplicationVM.problems[self.multiplicationVM.questionNumber].possibleAnswers[i]))
            }.environmentObject(multiplicationVM.multiplicationModel)
        }
    }
}
