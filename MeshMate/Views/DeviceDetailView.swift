//
//  DeviceDetailView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 28/05/25.
//

import SwiftUI

struct DeviceDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var device: Device
    var onSave: (Device) -> Void
    
    var body: some View {
        Form {
            Section(header: Text("Information")) {
                Text("Name: \(device.name)")
                Text("IP: \(device.ipAddress)")
                Text("Status: \(device.isBlocked ? "Blocked" : "Active")")
            }
            
            Section {
                Button(device.isBlocked ? "Unblock" : "Block") {
                    device.isBlocked.toggle()
                }
                .foregroundColor(device.isBlocked ? .green : .red)
            }
            
            Section {
                Button("Save") {
                    onSave(device)
                    dismiss()
                }
                .disabled(device.name.isEmpty)
            }
        }
        .navigationTitle("Device Details")
    }
}

#Preview {
    NavigationStack {
        DeviceDetailView(
            device: Device(id: UUID(), name: "MacBook", ipAddress: "192.168.0.42", isBlocked: false),
            onSave: { _ in }
        )
    }
}
