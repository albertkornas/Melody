//
//  ProblemStatus.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 8/30/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

//This view shows the progress of the user, and how many questions they have answered as well as whether they answered correctly or incorrectly

import SwiftUI

struct ProblemStatus: View {
    var body: some View {
        HStack {
            ForEach(0..<5) { i in
                if (i < 2) {
                    Circle()
                    .fill(Color.green)
                    .frame(width: 15, height: 15)
                } else if (i == 2){
                    Circle()
                    .fill(Color.red)
                    .frame(width: 15, height: 15)
                } else {
                    Circle()
                    .fill(Color.white)
                    .frame(width: 15, height: 15)
                }
            }
        }
    }
}

struct ProblemStatus_Previews: PreviewProvider {
    static var previews: some View {
        ProblemStatus()
    }
}
