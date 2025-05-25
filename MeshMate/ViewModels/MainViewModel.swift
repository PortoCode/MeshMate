//
//  MainViewModel.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 25/05/25.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var networkStatus: NetworkStatus?
    @Published var connectedDevices: [Device] = []
    
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        self.networkStatus = NetworkStatus(isOnline: true, latency: 14, downloadSpeedMbps: 230.5, uploadSpeedMbps: 100.2)
        
        self.connectedDevices = [
            Device(id: UUID(), name: "Rodrigo's iPhone", isBlocked: false, ipAddress: "192.168.0.12"),
            Device(id: UUID(), name: "Smart TV", isBlocked: true, ipAddress: "192.168.0.23"),
            Device(id: UUID(), name: "Notebook", isBlocked: false, ipAddress: "192.168.0.31")
        ]
    }
}
