//
//  NetworkStatusView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 03/08/25.
//

import SwiftUI

struct NetworkStatusView: View {
    let status: NetworkStatus
    
    var body: some View {
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
}

#Preview {
    NetworkStatusView(status: NetworkStatus(
        isOnline: true,
        latency: 100,
        downloadSpeedMbps: 120,
        uploadSpeedMbps: 90)
    )
}
