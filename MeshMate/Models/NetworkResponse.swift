//
//  NetworkResponse.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 25/05/25.
//

import Foundation

struct NetworkResponse: Decodable {
    let networkStatus: NetworkStatus
    let connectedDevices: [Device]
}
