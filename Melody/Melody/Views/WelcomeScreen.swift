//
//  WelcomeScreen.swift
//  Melody
//
//  Created by Albert Kornas on 11/21/20.
//

import SwiftUI
import StoreKit

struct WelcomeScreen: View {
    @EnvironmentObject var model: MelodyModel
    @EnvironmentObject var flowState: FlowState
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    Image("Logo")
                    
                    VStack(spacing: 18) {
                        Text("Melody")
                            .font(.system(size: 50, design: .rounded))
                        Text("Let's help you get started")
                            .font(.system(size: 14, design: .rounded))
                        
                        Button(action: {
                            self.flowState.process = .home
                        }) {
                            Text("Sign in using Apple Music")
                        }.disabled(model.musicToken == "" ? true : false)
                    }
                }
            }.navigationBarTitle("")
        }.onAppear {
                SKCloudServiceController.requestAuthorization { (status) in
                    if status == .authorized {
                        model.getUserToken()
                    }
                }
        }
    }
}
