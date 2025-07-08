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
        ZStack {
            VStack(spacing: 20) {
                Image("SplashIcon")
                    .resizable()
                    .frame(width: 220, height: 220)
                    .scaledToFit()
                
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
                    withAnimation {
                        auth.login()
                    }
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.white)
                .disabled(auth.username.isEmpty || auth.password.isEmpty)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LaunchBackground"))
            .ignoresSafeArea()
            
            if auth.loginFailed {
                VStack {
                    Spacer()
                    Text("Login failed. Please check your credentials.")
                        .padding()
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    auth.loginFailed = false
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    LoginView(auth: AuthManager())
}
