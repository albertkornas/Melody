//
//  HomeView.swift
//  Melody
//
//  Created by Albert Kornas on 11/5/20.
//

import SwiftUI
import StoreKit

struct HomeView: View {
    @EnvironmentObject var melodyModel : MelodyModel
    
    var body: some View {
            PlaylistListView(playlists: $melodyModel.playlists)
        .onAppear() {
            SKCloudServiceController.requestAuthorization { (status) in
                if status == .authorized {
                    melodyModel.fetchUserPlaylists()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
