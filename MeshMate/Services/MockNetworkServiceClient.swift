//
//  MockNetworkServiceClient.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 26/05/25.
//

import Foundation
import GRPC
import NIO
import SwiftProtobuf

final class MockNetworkServiceClient {
    func getNetworkStatus(completion: @escaping (Meshmate_NetworkStatusResponse) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let response = Meshmate_NetworkStatusResponse.with {
                $0.isOnline = true
                $0.latency = 15
                $0.downloadSpeedMbps = 300.5
                $0.uploadSpeedMbps = 120.3
            }
            completion(response)
        }
    }
    
    func getConnectedDevices(completion: @escaping (Meshmate_ConnectedDevicesResponse) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let devices = [
                Meshmate_Device.with {
                    $0.name = "Porto Machine"
                    $0.isBlocked = false
                    $0.ipAddress = "192.168.0.007"
                },
                Meshmate_Device.with {
                    $0.name = "iPhone 15 Pro"
                    $0.isBlocked = false
                    $0.ipAddress = "192.168.0.101"
                },
                Meshmate_Device.with {
                    $0.name = "MacBook Pro"
                    $0.isBlocked = false
                    $0.ipAddress = "192.168.0.102"
                },
                Meshmate_Device.with {
                    $0.name = "Echo Dot"
                    $0.isBlocked = true
                    $0.ipAddress = "192.168.0.103"
                }
            ]
            let response = Meshmate_ConnectedDevicesResponse.with {
                $0.devices = devices
            }
            completion(response)
        }
    }
}
