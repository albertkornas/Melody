//
//  HomeView.swift
//  Melody
//
//  Created by Albert Kornas on 11/5/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var melodyModel : MelodyModel
    
    var body: some View {
        VStack {
            //PlaylistListView(playlists: $melodyModel.playlists)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
