//
//  NetworkDataModel.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 31/05/25.
//

import SwiftUI

@MainActor
final class NetworkDataModel: ObservableObject {
    @Published var networkStatus: NetworkStatus?
    @Published var connectedDevices: [Device] = [] {
        didSet { DeviceStorage.save(connectedDevices) }
    }
    @Published var mode: NetworkMode = .rest
    @Published var isLoading: Bool = false
    
    private var grpcClient = MockNetworkServiceClient()
    
    init() {
        connectedDevices = DeviceStorage.load()
    }
    
    func loadData() {
        isLoading = true
        switch mode {
        case .rest:
            loadDataFromREST()
        case .grpc:
            loadDataFromGRPC()
        }
    }
    
    private func loadDataFromREST() {
        NetworkService.shared.fetchNetworkData { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success(let response):
                    self.networkStatus = response.networkStatus
                    withAnimation {
                        self.connectedDevices = response.connectedDevices
                    }
                case .failure(let error):
                    print("REST error: \(error)")
                }
                self.isLoading = false
            }
        }
    }
    
    private func loadDataFromGRPC() {
        isLoading = true
        let group = DispatchGroup()
        
        group.enter()
        grpcClient.getNetworkStatus { [weak self] response in
            DispatchQueue.main.async {
                self?.networkStatus = NetworkStatus(
                    isOnline: response.isOnline,
                    latency: Int(response.latency),
                    downloadSpeedMbps: response.downloadSpeedMbps,
                    uploadSpeedMbps: response.uploadSpeedMbps
                )
                group.leave()
            }
        }
        
        group.enter()
        grpcClient.getConnectedDevices { [weak self] response in
            DispatchQueue.main.async {
                withAnimation {
                    self?.connectedDevices = response.devices.map {
                        Device(id: UUID(), name: $0.name, ipAddress: $0.ipAddress, isBlocked: $0.isBlocked)
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
        }
    }
    
    func refreshDevices() {
        guard mode == .grpc else { return }
        isLoading = true
        grpcClient.getConnectedDevices { [weak self] response in
            DispatchQueue.main.async {
                withAnimation {
                    self?.connectedDevices = response.devices.map {
                        Device(id: UUID(), name: $0.name, ipAddress: $0.ipAddress, isBlocked: $0.isBlocked)
                    }
                }
                self?.isLoading = false
            }
        }
    }
    
    func updateDevice(_ device: Device) {
        if let index = connectedDevices.firstIndex(where: { $0.ipAddress == device.ipAddress }) {
            connectedDevices[index] = device
        }
    }
    
    func toggleBlock(for device: Device) {
        guard let idx = connectedDevices.firstIndex(where: { $0.id == device.id }) else { return }
        connectedDevices[idx].isBlocked.toggle()
    }
    
    func removeDevice(_ device: Device) {
        connectedDevices.removeAll { $0.id == device.id }
    }
}
