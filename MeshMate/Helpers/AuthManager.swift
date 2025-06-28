//
//  AuthManager.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 27/06/25.
//

import SwiftUI

final class AuthManager: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @Published var username: String = ""
    @Published var password: String = ""
    
    func login() {
        if !username.isEmpty && !password.isEmpty {
            isLoggedIn = true
        }
    }
    
    func logout() {
        isLoggedIn = false
        username = ""
        password = ""
    }
}
