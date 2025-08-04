//
//  ConnectedDevicesListView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 03/08/25.
//

import SwiftUI

struct ConnectedDevicesListView: View {
    let devices: [Device]
    let mode: NetworkMode
    let onSelect: (Device) -> Void
    let onToggleBlock: (Device) -> Void
    let onRemove: (Device) -> Void
    let onRefresh: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            List {
                Section(header: Label("Connected Devices", systemImage: "person.3.sequence")) {
                    ForEach(devices) { device in
                        Button {
                            onSelect(device)
                        } label: {
                            DeviceRowView(name: device.name, ipAddress: device.ipAddress, isBlocked: device.isBlocked)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button(device.isBlocked ? "Unblock" : "Block") {
                                onToggleBlock(device)
                            }
                            Button("Remove", role: .destructive) {
                                onRemove(device)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .frame(maxHeight: 300)
            
            if mode == .grpc {
                Button {
                    onRefresh()
                } label: {
                    Label("Update Devices", systemImage: "arrow.triangle.2.circlepath")
                }
                .buttonStyle(.bordered)
                .padding(.bottom, 8)
            }
        }
        .padding(.top, 1)
    }
}

#Preview {
    ConnectedDevicesListView(
        devices: [
            Device(id: UUID(), name: "iPhone 15 Pro", ipAddress: "192.168.0.2", isBlocked: false),
            Device(id: UUID(), name: "MacBook Pro", ipAddress: "192.168.0.3", isBlocked: true)
        ],
        mode: .grpc,
        onSelect: { device in
            print("Selected \(device.name)")
        },
        onToggleBlock: { device in
            print("\(device.isBlocked ? "Unblocking" : "Blocking") \(device.name)")
        },
        onRemove: { device in
            print("Removing \(device.name)")
        },
        onRefresh: {
            print("Refreshing device list")
        }
    )
}
