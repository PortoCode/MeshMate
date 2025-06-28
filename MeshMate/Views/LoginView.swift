//
//  LoginView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 27/06/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var auth: AuthManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("MeshMate")
                .font(.largeTitle)
                .bold()
            
            TextField("Usuário", text: $auth.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Senha", text: $auth.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Entrar") {
                auth.login()
            }
            .buttonStyle(.borderedProminent)
            .disabled(auth.username.isEmpty || auth.password.isEmpty)
        }
        .padding()
    }
}

#Preview {
    LoginView(auth: AuthManager())
}
