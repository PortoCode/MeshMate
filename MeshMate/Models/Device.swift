//
//  Device.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 25/05/25.
//

import Foundation

struct Device: Identifiable {
    let id: UUID
    let name: String
    let isBlocked: Bool
    let ipAddress: String
}
