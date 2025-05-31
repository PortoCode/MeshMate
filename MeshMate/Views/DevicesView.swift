//
//  DevicesView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 31/05/25.
//

import SwiftUI

struct DevicesView: View {
    @ObservedObject var viewModel: DevicesViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.connectedDevices) { device in
                NavigationLink {
                    DeviceDetailView(device: device) { updated in
                        viewModel.updateDevice(updated)
                    }
                } label: {
                    DeviceRowView(name: device.name, ipAddress: device.ipAddress, isBlocked: device.isBlocked)
                }
            }
            .navigationTitle("All Devices")
        }
    }
}
