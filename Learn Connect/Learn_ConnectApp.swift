//
//  Learn_ConnectApp.swift
//  Learn Connect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct Learn_ConnectApp: App {
    @AppStorage("appearance") private var appearance: Appearance = .system
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            LoginSignupView()
                .preferredColorScheme(appearance.colorScheme)
        }
    }
}
