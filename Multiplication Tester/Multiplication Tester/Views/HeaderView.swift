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
    var modeOfArithmetic : String {arithmeticModel.modeIndex.rawValue.capitalized}
    var difficulty: String {arithmeticModel.difficultyIndex.rawValue.capitalized}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.5) {
        Text("\(modeOfArithmetic) Challenge")
            .font(.largeTitle)
        Text("\(difficulty) mode")
            .font(.caption)
        }
    }
}

