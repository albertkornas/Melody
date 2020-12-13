//
//  CurrentlyPlayingBar.swift
//  Melody
//
//  Created by Albert Kornas on 12/11/20.
//

import SwiftUI

struct CurrentlyPlayingBar: View {
    //var song: Song?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle().foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.size.width, height: 65)
        }
    }
}
