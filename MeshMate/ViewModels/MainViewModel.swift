//
//  MainViewModel.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 25/05/25.
//

import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    @ObservedObject var model: NetworkDataModel
    
    init(model: NetworkDataModel) {
        self.model = model
    }
    
    var networkStatus: NetworkStatus? {
        model.networkStatus
    }
    
    var connectedDevices: [Device] {
        model.connectedDevices
    }
    
    var isLoading: Bool {
        model.isLoading
    }
    
    var mode: NetworkMode {
        get { model.mode }
        set { model.mode = newValue }
    }
    
    func loadData() {
        model.loadData()
    }
    
    func refreshDevices() {
        model.refreshDevices()
    }
    
    func updateDevice(_ device: Device) {
        model.updateDevice(device)
    }
    
    func toggleBlock(for device: Device) {
        model.toggleBlock(for: device)
    }
    
    func removeDevice(_ device: Device) {
        model.removeDevice(device)
    }
}
