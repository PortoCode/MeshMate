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
}
