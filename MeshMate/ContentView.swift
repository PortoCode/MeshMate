//
//  ContentView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 22/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("MeshMate")
                        .font(.largeTitle)
                        .bold()
                    Text("Network Status: Online")
                        .font(.subheadline)
                        .foregroundStyle(.green)
                    Text("Latency: 12ms • Speed: 200Mbps")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding()
                
                List {
                    Section {
                        DeviceRowView(name: "Rodrigo's iPhone", isBlocked: false)
                        DeviceRowView(name: "Smart TV", isBlocked: true)
                        DeviceRowView(name: "Alexa Echo Dot", isBlocked: false)
                    } header: {
                        Text("Connected Devices")
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("My Network")
    }
}

struct DeviceRowView: View {
    let name: String
    let isBlocked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isBlocked ? "xmark.shield" : "wifi")
                .foregroundStyle(isBlocked ? .red : .blue)
            Text(name)
            Spacer()
            Text(isBlocked ? "Blocked" : "Active")
                .font(.caption)
                .foregroundStyle(isBlocked ? .red : .green)
        }
    }
}

#Preview {
    ContentView()
}
