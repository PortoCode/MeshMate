//
//  SettingsView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 31/05/25.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject var auth: AuthManager
    @State private var isNotificationsEnabled: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Label("Account", systemImage: "person.circle")) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                        Text(auth.username)
                            .font(.body)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.vertical, 5)
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
                    Button {
                        HapticsManager.impact(style: .light)
                        requestAppReview()
                    } label: {
                        Label("Rate the App", systemImage: "star.bubble")
                    }
                }
                Section {
                    Button(role: .destructive) {
                        HapticsManager.impact(style: .light)
                        auth.logout()
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
    
    private func requestAppReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            AppStore.requestReview(in: scene)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthManager(previewUsername: "john.doe"))
}
