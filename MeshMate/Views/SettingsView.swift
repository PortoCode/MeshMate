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
                Section(
                    header: Label("Notifications", systemImage: "bell.badge"),
                    footer: Text("Receive updates and alerts directly.")
                ) {
                    Toggle(isOn: $isNotificationsEnabled) {
                        Text("Enable Notifications")
                    }
                }
                Section(header: Label("About", systemImage: "info.circle")) {
                    Text("MeshMate v1.0")
                }
                Section {
                    Button(role: .destructive) {
                        // log out logic
                    } label: {
                        Text("Log Out")
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Text("© 2025 MeshMate Inc.")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
