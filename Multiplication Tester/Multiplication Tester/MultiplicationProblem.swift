//
//  MultiplicationProblem.swift
//  Multiplication Tester
//
//  Created by Albert Kornas on 8/30/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

//This view displays the number of the problem, as well as the arithemtic problem itself.
import SwiftUI

struct MultiplicationProblem: View {
    var body: some View {
         VStack {
            Text("Problem 4")
            Spacer().frame(height:20)
            
                       VStack(alignment: .trailing) {
                           Text("17")
                               .font(.headline)
                           HStack {
                               Text("X")
                                   .font(.headline)
                               Text("  8")
                                   .font(.headline)
                           }
                       }
                       Rectangle().frame(width:75, height:3)
                   }
    }
}

struct MultiplicationProblem_Previews: PreviewProvider {
    static var previews: some View {
        MultiplicationProblem()
    }
}
