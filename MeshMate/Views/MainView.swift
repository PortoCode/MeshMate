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
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 16) {
                NetworkModePickerView(mode: $viewModel.mode)
                
                if let status = viewModel.networkStatus {
                    NetworkStatusView(status: status)
                }
                
                if !viewModel.connectedDevices.isEmpty {
                    List {
                        Section(header: Label("Connected Devices", systemImage: "person.3.sequence")) {
                            ForEach(viewModel.connectedDevices) { device in
                                Button {
                                    selectedDevice = device
                                    navigationPath.append(device)
                                } label: {
                                    DeviceRowView(name: device.name, ipAddress: device.ipAddress, isBlocked: device.isBlocked)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .buttonStyle(.plain)
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
            .navigationDestination(for: Device.self) { device in
                DeviceDetailView(device: device) { updated in
                    viewModel.updateDevice(updated)
                    if selectedDevice == device {
                        selectedDevice = nil
                        if !navigationPath.isEmpty {
                            navigationPath.removeLast()
                        }
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
