//
//  SettingsView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 31/05/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var isNotificationsEnabled: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Label("Account", systemImage: "person.circle")) {
                    Text("Profile settings go here…")
                }
                Section(header: Label("Notifications", systemImage: "bell.badge")) {
                    Toggle(isOn: $isNotificationsEnabled) {
                        Text("Enable Notifications")
                    }
                }
                Section(header: Label("About", systemImage: "info.circle")) {
                    Text("MeshMate v1.0")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
