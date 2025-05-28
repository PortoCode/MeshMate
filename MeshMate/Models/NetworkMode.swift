//
//  NetworkMode.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 27/05/25.
//

import Foundation

enum NetworkMode: String, CaseIterable, Identifiable {
    case rest = "REST"
    case grpc = "gRPC"
    
    var id: String { self.rawValue }
}
