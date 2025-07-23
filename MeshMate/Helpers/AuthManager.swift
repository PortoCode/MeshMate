//
//  AuthManager.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 27/06/25.
//

import SwiftUI

final class AuthManager: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("username") var username: String = ""
    @Published var password: String = ""
    @Published var loginFailed: Bool = false
    
    private let defaultPassword = "1234"
    
    init(previewUsername: String? = nil) {
        if let previewUsername {
            self.username = previewUsername
        }
    }
    
    func login() {
        if !username.isEmpty && !password.isEmpty {
            if password == defaultPassword {
                isLoggedIn = true
                loginFailed = false
            } else {
                loginFailed = true
            }
        } else {
            loginFailed = true
        }
    }
    
    func logout() {
        isLoggedIn = false
        username = ""
        password = ""
    }
}
