//
//  SplashScreenView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 31/05/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var iconScale: CGFloat = 0.8
    @State private var iconOpacity: Double = 0.0
    @State private var textScale: CGFloat = 0.8
    @State private var textOpacity: Double = 0.0
    
    var onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image("SplashIcon")
                .resizable()
                .frame(width: 280, height: 280)
                .scaledToFit()
                .scaleEffect(iconScale)
                .opacity(iconOpacity)
            
            Text("MeshMate")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .scaleEffect(textScale)
                .opacity(textOpacity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LaunchBackground"))
        .ignoresSafeArea()
        .onAppear {
            // Animate icon fade + scale in
            withAnimation(.easeOut(duration: 1.0)) {
                iconScale = 1.0
                iconOpacity = 1.0
            }
            
            // Slight delay then animate text fade + scale in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    textScale = 1.0
                    textOpacity = 1.0
                }
            }
            
            // After total delay, fade out both and switch screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeIn(duration: 0.6)) {
                    iconOpacity = 0
                    iconScale = 1.2
                    textOpacity = 0
                    textScale = 1.2
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    onComplete()
                }
            }
        }
    }
}
