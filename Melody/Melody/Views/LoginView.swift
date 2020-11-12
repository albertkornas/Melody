//
//  LoginView.swift
//  Melody
//
//  Created by Albert Kornas on 11/4/20.
//

import SwiftUI
import StoreKit

struct LoginView: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear() {
                SKCloudServiceController.requestAuthorization { (status) in
                    if status == .authorized {
                        print("Status authorized")
                        print(MelodyModel().fetchUserPlaylists())
                    }
                }
            }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
