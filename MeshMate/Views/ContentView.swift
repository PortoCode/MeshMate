//
//  ContentView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 22/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if let status = viewModel.networkStatus {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("MeshMate")
                            .font(.largeTitle).bold()
                        Text("Network Status: \(status.isOnline ? "Online" : "Offline")")
                            .font(.subheadline)
                            .foregroundStyle(status.isOnline ? .green : .red)
                        Text("Latency: \(status.latency)ms • ↓ \(Int(status.downloadSpeedMbps))Mbps • ↑ \(Int(status.uploadSpeedMbps))Mbps")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                }
                
                List {
                    Section {
                        ForEach(viewModel.connectedDevices) { device in
                            DeviceRowView(name: device.name, isBlocked: device.isBlocked)
                        }
                    } header: {
                        Text("Connected Devices")
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("My Network")
        }
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
