//
//  DeviceStorage.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 28/05/25.
//

import Foundation

struct DeviceStorage {
    private static let key = "storedDevices"
    
    static func save(_ devices: [Device]) {
        if let data = try? JSONEncoder().encode(devices) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    static func load() -> [Device] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Device].self, from: data) else {
            return []
        }
        return decoded
    }
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
