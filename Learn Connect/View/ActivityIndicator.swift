//
//  ActivityIndicator.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI

struct ActivityIndicator: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        if isLoading {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
                .padding(10)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
    }
}
