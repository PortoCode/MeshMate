//
//  MainView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 22/05/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var selectedDevice: Device? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack {
                    Text("Network Mode")
                        .font(.headline)
                        .padding(.horizontal)
                    Picker("Network Mode", selection: $viewModel.mode) {
                        ForEach(NetworkMode.allCases) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                }
                
                if let status = viewModel.networkStatus {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Image(systemName: "dot.radiowaves.left.and.right")
                            Text("My Network")
                                .font(.largeTitle).bold()
                        }
                        Text("Network Status: \(status.isOnline ? "Online" : "Offline")")
                            .font(.subheadline)
                            .foregroundStyle(status.isOnline ? .green : .red)
                        Text("Latency: \(status.latency)ms • ↓ \(Int(status.downloadSpeedMbps))Mbps • ↑ \(Int(status.uploadSpeedMbps))Mbps")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                }
                
                if !viewModel.connectedDevices.isEmpty {
                    List {
                        Section(header: Label("Connected Devices", systemImage: "person.3.sequence")) {
                            ForEach(viewModel.connectedDevices) { device in
                                NavigationLink(
                                    destination: DeviceDetailView(device: device) { updated in
                                        viewModel.updateDevice(updated)
                                        selectedDevice = nil
                                    },
                                    tag: device,
                                    selection: $selectedDevice
                                ) {
                                    DeviceRowView(name: device.name, ipAddress: device.ipAddress, isBlocked: device.isBlocked)
                                }
                                .contextMenu {
                                    Button(device.isBlocked ? "Unblock" : "Block") {
                                        viewModel.toggleBlock(for: device)
                                    }
                                    Button("Remove", role: .destructive) {
                                        viewModel.removeDevice(device)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .frame(maxHeight: 300)
                    .padding(.top, 1)
                    
                    if viewModel.mode == .grpc {
                        Button {
                            viewModel.refreshDevices()
                        } label: {
                            Label("Update Devices", systemImage: "arrow.triangle.2.circlepath")
                        }
                        .buttonStyle(.bordered)
                        .padding(.bottom, 8)
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView("Loading…")
                        .padding(.bottom, 4)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.loadData()
                }) {
                    Label("Load Data", systemImage: "tray.and.arrow.down")
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("MeshMate")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
    }
}

#Preview {
    let authManager = AuthManager(previewUsername: "john.doe")
    return MainView(viewModel: MainViewModel(model: NetworkDataModel()))
        .environmentObject(authManager)
}
