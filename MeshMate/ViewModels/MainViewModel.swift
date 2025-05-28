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
        loadDataFromREST()
        loadNetworkStatusFromGRPC()
        loadDevicesFromGRPC()
    }
    
    func loadDataFromREST() {
        NetworkService.shared.fetchNetworkData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.networkStatus = response.networkStatus
                    self?.connectedDevices = response.connectedDevices
                case .failure(let error):
                    print("Error loading mocked data: \(error)")
                }
            }
        }
    }
    
    func loadNetworkStatusFromGRPC() {
        let grpcClient = MockNetworkServiceClient()
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
    
    func loadDevicesFromGRPC() {
        let grpcClient = MockNetworkServiceClient()
        grpcClient.getConnectedDevices { [weak self] response in
            DispatchQueue.main.async {
                self?.connectedDevices = response.devices.map {
                    Device(id: UUID(), name: $0.name, isBlocked: $0.isBlocked, ipAddress: $0.ipAddress)
                }
            }
        }
    }
}
