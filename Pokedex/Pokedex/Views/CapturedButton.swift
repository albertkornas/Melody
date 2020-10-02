//
//  CapturedButton.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/29/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct CapturedButton: View {
    @Binding var isCaptured: Bool
    var body: some View {
        Button(action: {self.isCaptured.toggle()}) {
            Text(isCaptured ? "Mark as Released" : "Mark as Captured")
                .padding()
                .foregroundColor(isCaptured ? .red : .blue)
        }
    }
}

struct CapturedButton_Previews: PreviewProvider {
    @State static var captured = true
    static var previews: some View {
        CapturedButton(isCaptured: $captured)
    }
}
