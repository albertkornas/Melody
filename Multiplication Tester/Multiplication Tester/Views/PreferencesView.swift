//
//  PreferencesView.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/16/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    @Binding var isShowingPreferences : Bool
    @Binding var questionsPerRound : Int
    let arithmeticModel : ArithmeticModel
    @Binding var difficultyIndex : ArithmeticModel.Difficulty
    @Binding var modeIndex : ArithmeticModel.Mode
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Length of Sequence")) {
                    Stepper(value: $questionsPerRound, in: 3...7) {
                        Text("\(arithmeticModel.questionsPerRound)")
                    }
                }
                
                Section(header: Text("Choose Difficulty")) {
                    Picker("Difficulty", selection: $difficultyIndex) {
                        ForEach(ArithmeticModel.Difficulty.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    
                }
                
                Section(header: Text("Choose Arithmetic Mode")) {
                    Picker("Mode", selection: $modeIndex) {
                        ForEach(ArithmeticModel.Mode.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    
                }
                
                Section() {

                    Button("Dismiss") { self.isShowingPreferences.toggle() }
                    
                }.navigationBarTitle("Preferences")
            }
            
        }
    }
}

