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
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Multiplication Exercises")
                    .font(.largeTitle)
                Spacer().frame(height:60)
                
                //Show the 5 circles displaying status of problems (correct, incorrect, or N/A)
                ProblemStatus()
                Text("You've answered 2/5 questions correctly")
                    .font(.caption)
                Spacer().frame(height:50)
                
                
                //Show the randomly generated multiplication problem
                MultiplicationProblem()
                Spacer().frame(height: 30)
                
                AnswerButtons()
                Spacer().frame(height:30)
                Button(action: {
                }) {
                    
                    Text("Next Question")
                        .padding(7.5)
                    .cornerRadius(5)
                    .disabled(true)
                }

            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}


struct AnswerButtons: View {
    var body: some View {
        HStack {
            ForEach(0..<4) { i in
                Button(action: {
                    //Placeholder for action
                }) {
                    //Will eventually be randomly generated
                    Text("123")
                        .padding(7.5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                    .cornerRadius(5)
                }
            }
        }
    }
}
