//
//  FavButton.swift
//  Campus
//
//  Created by Albert Kornas on 10/7/20.
//

import SwiftUI

struct FavButton: View {
    @Binding var isFavorited: Bool
    var body: some View {
        Button(action: {
            self.isFavorited.toggle()
        }) {
            Image(systemName: self.isFavorited ? "star.fill" : "star")
        }
    }
}
