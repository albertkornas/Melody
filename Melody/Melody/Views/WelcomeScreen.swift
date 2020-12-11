//
//  WelcomeScreen.swift
//  Melody
//
//  Created by Albert Kornas on 11/21/20.
//

import SwiftUI

struct WelcomeScreen: View {
    @Binding var str : String
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
                        NavigationLink(destination: MainTabView(selection: $str)) {
                            Text("Sign in")
                        }
                    }
                }
            }.navigationBarTitle("")
        }
    }
}
