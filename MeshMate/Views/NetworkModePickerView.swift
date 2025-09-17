//
//  NetworkModePickerView.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 03/08/25.
//

import SwiftUI

struct NetworkModePickerView: View {
    @Binding var mode: NetworkMode
    
    var body: some View {
        VStack {
            Text("Network Mode")
                .font(.headline)
                .padding(.horizontal)
            Picker("Network Mode", selection: $mode) {
                ForEach(NetworkMode.allCases) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .onChange(of: mode) {
                HapticsManager.impact(style: .light)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedMode: NetworkMode = .rest
        
        var body: some View {
            NetworkModePickerView(mode: $selectedMode)
        }
    }
    
    return PreviewWrapper()
}
