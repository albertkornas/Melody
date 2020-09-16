//
//  Color+Background.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 9/15/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static func background(for state: ProblemState) -> Color {
        switch state {
            case .correct:
                return Color.green
            case .incorrect:
                return Color.red
        default:
            return Color.white
            }
    }
    
    static func fontColor(for difficulty: ArithmeticModel.Difficulty) -> Color {
        switch difficulty {
        case .easy:
            return Color.green
        case .medium:
            return Color.yellow
        case .hard:
            return Color.red
            }
    }
}

