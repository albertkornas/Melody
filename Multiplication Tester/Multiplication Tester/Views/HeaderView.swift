//
//  HeaderView.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/16/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    let arithmeticModel : ArithmeticModel
    var difficulty : ArithmeticModel.Difficulty { arithmeticModel.difficultyIndex}
    var modeOfArithmeticText : String {arithmeticModel.modeIndex.rawValue.capitalized}
    var difficultyText: String {arithmeticModel.difficultyIndex.rawValue.capitalized}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.5) {
        Text("\(modeOfArithmeticText) Challenge")
            .font(.largeTitle)
        Text("\(difficultyText) Difficulty")
            .font(.body)
            .foregroundColor(Color.fontColor(for: difficulty))
        }
    }
}

