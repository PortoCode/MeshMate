//
//  MainView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 22/05/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker("Network Mode", selection: $viewModel.mode) {
                    ForEach(NetworkMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if let status = viewModel.networkStatus {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("My Network")
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
                
                if !viewModel.connectedDevices.isEmpty {
                    List {
                        Section {
                            ForEach(viewModel.connectedDevices) { device in
                                NavigationLink {
                                    DeviceDetailView(device: device) { updated in
                                        viewModel.updateDevice(updated)
                                    }
                                } label: {
                                    DeviceRowView(name: device.name, ipAddress: device.ipAddress, isBlocked: device.isBlocked)
                                }
                            }
                        } header: {
                            Text("Connected Devices")
                        }
                    }
                    .listStyle(.insetGrouped)
                    
                    if viewModel.mode == .grpc {
                        Button("🔄 Update Devices") {
                            viewModel.refreshDevices()
                        }
                        .padding(.bottom)
                    }
                }
                
                Spacer()
                
                Button("Load Data") {
                    viewModel.loadData()
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("MeshMate")
        }
    }
}

struct DeviceRowView: View {
    let name: String
    let ipAddress: String
    let isBlocked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isBlocked ? "xmark.shield" : "wifi")
                .foregroundStyle(isBlocked ? .red : .blue)
            VStack(alignment: .leading) {
                Text(name)
                    .fontWeight(.semibold)
                Text(ipAddress)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(isBlocked ? "Blocked" : "Active")
                .font(.caption)
                .foregroundStyle(isBlocked ? .red : .green)
        }
    }
}

#Preview {
    MainView()
}
