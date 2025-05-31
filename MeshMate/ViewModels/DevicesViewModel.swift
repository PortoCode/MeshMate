//
//  DevicesViewModel.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 31/05/25.
//

import SwiftUI

@MainActor
final class DevicesViewModel: ObservableObject {
    @ObservedObject var model: NetworkDataModel
    
    init(model: NetworkDataModel) {
        self.model = model
    }
    
    var connectedDevices: [Device] {
        model.connectedDevices
    }
    
    func updateDevice(_ device: Device) {
        model.updateDevice(device)
    }
}
