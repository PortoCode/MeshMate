//
//  MeshMateApp.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 22/05/25.
//

import SwiftUI

@main
struct MeshMateApp: App {
    @StateObject private var auth = AuthManager()
    @State private var didShowSplash = false
    
    var body: some Scene {
        WindowGroup {
            if !didShowSplash {
                SplashScreenView {
                    didShowSplash = true
                }
            } else {
                if auth.isLoggedIn {
                    MainTabBar()
                        .environmentObject(auth)
                } else {
                    LoginView(auth: auth)
                }
            }
        }
    }
}
