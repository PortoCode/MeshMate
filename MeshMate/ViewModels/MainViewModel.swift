//
//  MainViewModel.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 25/05/25.
//

import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    @Published var networkStatus: NetworkStatus?
    @Published var connectedDevices: [Device] = []
    @Published var mode: NetworkMode = .rest
    
    private var grpcClient = MockNetworkServiceClient()
    
    func loadData() {
        switch mode {
        case .rest:
            loadDataFromREST()
        case .grpc:
            loadDataFromGRPC()
        }
    }
    
    func loadDataFromREST() {
        NetworkService.shared.fetchNetworkData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.networkStatus = response.networkStatus
                    withAnimation {
                        self?.connectedDevices = response.connectedDevices
                    }
                case .failure(let error):
                    print("Error loading mocked data: \(error)")
                }
            }
        }
    }
    
    func loadDataFromGRPC() {
        loadNetworkStatusFromGRPC()
        loadDevicesFromGRPC()
    }
    
    func refreshDevices() {
        guard mode == .grpc else { return }
        loadDevicesFromGRPC()
    }
    
    private func loadNetworkStatusFromGRPC() {
        grpcClient.getNetworkStatus { [weak self] response in
            DispatchQueue.main.async {
                self?.networkStatus = NetworkStatus(
                    isOnline: response.isOnline,
                    latency: Int(response.latency),
                    downloadSpeedMbps: response.downloadSpeedMbps,
                    uploadSpeedMbps: response.uploadSpeedMbps
                )
            }
        }
    }
    
    private func loadDevicesFromGRPC() {
        grpcClient.getConnectedDevices { [weak self] response in
            DispatchQueue.main.async {
                withAnimation {
                    self?.connectedDevices = response.devices.map {
                        Device(id: UUID(), name: $0.name, isBlocked: $0.isBlocked, ipAddress: $0.ipAddress)
                    }
                }
            }
        }
    }
}
