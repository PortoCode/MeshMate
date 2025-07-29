//
//  RootView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 28/06/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var auth = AuthManager()
    @State private var didShowSplash = false
    
    var body: some View {
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

#Preview {
    RootView()
}
