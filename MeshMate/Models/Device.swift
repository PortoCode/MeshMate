//
//  Device.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 25/05/25.
//

import Foundation

struct Device: Identifiable, Codable {
    let id: UUID
    var name: String
    var ipAddress: String
    var isBlocked: Bool
}
