//
//  NetworkStatus.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 25/05/25.
//

import Foundation

struct NetworkStatus: Decodable {
    let isOnline: Bool
    let latency: Int
    let downloadSpeedMbps: Double
    let uploadSpeedMbps: Double
}
