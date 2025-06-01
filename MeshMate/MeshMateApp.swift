//
//  MeshMateApp.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 22/05/25.
//

import SwiftUI

@main
struct MeshMateApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 5) // 2 seconds delay
        return true
    }
}
