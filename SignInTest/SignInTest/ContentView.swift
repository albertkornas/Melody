//
//  ContentView.swift
//  SignInTest
//
//  Created by Albert Kornas on 10/6/20.
//

import GoogleSignIn
import SwiftUI
struct SignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        // Customize button here
        button.colorScheme = .light
        return button
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct ContentView: View {
    @EnvironmentObject var googleDelegate: GoogleDelegate
    
    var body: some View {
        SignInButton()
        
    }
}
