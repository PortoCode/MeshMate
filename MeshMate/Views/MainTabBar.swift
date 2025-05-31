//
//  MainTabBar.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 31/05/25.
//

import SwiftUI

struct MainTabBar: View {
    @StateObject private var networkModel = NetworkDataModel()
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                MainView(viewModel: MainViewModel(model: networkModel))
            }
            
            Tab("Devices", systemImage: "wifi") {
                DevicesView(viewModel: DevicesViewModel(model: networkModel))
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
    }
}

#Preview {
    MainTabBar()
}
