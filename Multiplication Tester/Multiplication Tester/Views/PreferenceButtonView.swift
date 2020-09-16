//
//  PreferenceButtonView.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/16/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct PreferenceButtonView : View {
    @State private  var isShowingPreference = false
    @Binding var questionsPerRound : Int
    @Binding var difficultyIndex : ArithmeticModel.Difficulty
    let arithmeticModel : ArithmeticModel
    @Binding var modeIndex: ArithmeticModel.Mode
    var body: some View {
   
        Button(action: { self.isShowingPreference.toggle() }) {
            Image(systemName: "gear")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(.black)
                .padding(10)
        }.sheet(isPresented: $isShowingPreference) {
            PreferencesView(isShowingPreferences: self.$isShowingPreference, questionsPerRound: self.$questionsPerRound, arithmeticModel: self.arithmeticModel, difficultyIndex: self.$difficultyIndex, modeIndex: self.$modeIndex)
            
        }
        
    }
}
