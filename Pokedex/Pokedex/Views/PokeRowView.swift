//
//  PokeRowView.swift
//  Pokedex
//
//  Created by Albert Kornas on 9/23/20.
//  Copyright © 2020 Albert Kornas. All rights reserved.
//

import SwiftUI

struct PokeRowView: View {
    var pokemon: Pokemon
    var body: some View {
        HStack {
            
            Text(String(format: "%03d", pokemon.id))
            Image(String(format: "%03d", pokemon.id))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: nil, height: rowHeight, alignment: .center)
                .imageScale(.small)
                .padding()
            Spacer()
            Text(pokemon.name)
    
            
        }
    }
    let rowHeight : CGFloat = 50
}
/*
struct PokeRowView_Previews: PreviewProvider {
    static var previews: some View {
        PokeRowView()
    }
}
*/
