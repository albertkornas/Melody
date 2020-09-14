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
    //@ObservedObject var multiplicationViewModel = MultiplicationViewModel()
    @State private var multiplicationModel = MultiplicationModel()
    
    var questionNumber : Int {multiplicationModel.currentQuestionCount}
    var totalQuestions : Int {multiplicationModel.problemCount}
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Multiplication Exercises")
                    .font(.largeTitle)
                Spacer().frame(height:60)
                
                //Show the 5 circles displaying status of problems (correct, incorrect, or N/A)
                ProblemStatusView(withModel: multiplicationModel)
                Text("You've answered \(multiplicationModel.currentQuestionCount)/\(totalQuestions) questions correctly")
                    .font(.caption)
                Spacer().frame(height:50)
                
                
                //Show the randomly generated multiplication problem
                MultiplicationProblemView(withModel: multiplicationModel)
                Spacer().frame(height: 30)
                
                //AnswerButtons(withModel: multiplicationModel)
                HStack {
                    ForEach(0..<(self.multiplicationModel.problems[0].answerChoices)) { i in
                        
                        
                        GuessButtonView(model: self.$multiplicationModel, color:Color.blue, index: i, numString: String(self.multiplicationModel.problems[self.questionNumber].possibleAnswers[i]))
                    }.environmentObject(multiplicationModel)
                }
                
                Spacer().frame(height:30)
                Button(action: {
                    self.multiplicationModel.nextQuestion()
                }) {
                    
                    Text(self.multiplicationModel.nextQuestionText)
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


/*struct AnswerButtons: View {
    let multiplicationModel : MultiplicationModel
    init(withModel: MultiplicationModel) {
        multiplicationModel = withModel
    }
    var questionNumber : Int {multiplicationModel.currentQuestionCount}
    var body: some View {
        HStack {
            ForEach(0..<(self.multiplicationModel.problems[0].answerChoices)) { i in
                
                
                GuessButtonView(multiplicationModel: $multiplicationModel, color:Color.blue, index: i, numString: String(self.multiplicationModel.problems[self.questionNumber].possibleAnswers[i]))
            }.environmentObject(multiplicationModel)
        }
    }
}*/
