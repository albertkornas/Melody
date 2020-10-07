//
//  SignInTestApp.swift
//  SignInTest
//
//  Created by Albert Kornas on 10/6/20.
//

import SwiftUI
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
              print("The user has not signed in before or they have since signed out.")
            } else {
              print("\(error.localizedDescription)")
            }
            return
          }
          // Perform any operations on signed in user here.
          let userId = user.userID                  // For client-side use only!
          let idToken = user.authentication.idToken // Safe to send to the server
          let fullName = user.profile.name
          let givenName = user.profile.givenName
          let familyName = user.profile.familyName
          let email = user.profile.email
        print(email)
        print(fullName)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    

    
    // GIDSignIn's delegate is a weak property, so we have to define our GoogleDelegate outside the function to prevent it from being deallocated.
    let googleDelegate = GoogleDelegate()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("HI")
        GIDSignIn.sharedInstance().clientID = "871581799788-5aqah00jd7tbeflpm11346g3il36urke.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = googleDelegate
        
        
        return true
    }
    
    func scene(_ scene: UIScene,
          willConnectTo session: UISceneSession,
          options connectionOptions: UIScene.ConnectionOptions) {
        print("Hello")
        // Get the googleDelegate from AppDelegate
            let googleDelegate = (UIApplication.shared.delegate as! AppDelegate).googleDelegate
            // Add googleDelegate as an environment object
            let contentView = ContentView()
                .environmentObject(googleDelegate)
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: contentView)
                // Set presentingViewControll to rootViewController
                GIDSignIn.sharedInstance().presentingViewController = window.rootViewController
                //self.window = window
                window.makeKeyAndVisible()
            }
    }

    
    
    
}

@main
struct SignInTestApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { (newScenePhase) in
                    switch newScenePhase {
                    case .active:
                        print("Scene is now active")
                    case .inactive:
                        print("scene is now inactive!")
                    case .background:
                        print("scene is now in the background!")
                    @unknown default:
                        print("Apple must have added something new!")
                    }
                }
        
    }
}
