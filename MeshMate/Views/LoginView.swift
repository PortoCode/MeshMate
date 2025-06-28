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
                .foregroundStyle(.white)
            
            TextField("Username", text: $auth.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Password", text: $auth.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Login") {
                auth.login()
            }
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.white)
            .disabled(auth.username.isEmpty || auth.password.isEmpty)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LaunchBackground"))
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView(auth: AuthManager())
}
