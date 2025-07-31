//
//  DeviceRowView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 31/05/25.
//

import SwiftUI

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
    DeviceRowView(
        name: "MacBook",
        ipAddress: "192.168.0.42",
        isBlocked: false
    )
}
