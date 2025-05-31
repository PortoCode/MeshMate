//
//  SettingsView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 31/05/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Account")) {
                    Text("Profile settings go here…")
                }
                Section(header: Text("About")) {
                    Text("MeshMate v1.0")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
