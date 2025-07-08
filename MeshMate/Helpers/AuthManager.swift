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
    @Published var loginFailed: Bool = false
    
    func login() {
        if !username.isEmpty && !password.isEmpty {
            if username == "admin" && password == "1234" {
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
