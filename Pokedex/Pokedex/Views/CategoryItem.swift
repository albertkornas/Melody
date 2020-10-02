//
//  CategoryItem.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/29/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct CategoryItem: View {
    @Binding var thePokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(String(format: "%03d", thePokemon.id))
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: frameSize, height: frameSize)
                .cornerRadius(5)
            Text(thePokemon.name)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
    let frameSize : CGFloat = 155
}
