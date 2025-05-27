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
        loadDataFromGRPC()
    }
    
    func loadMockData() {
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
    
    func loadDataFromGRPC() {
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
}
