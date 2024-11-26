//
//  ShimmerEffectView.swift
//  Learn Connect
//
//  Created by kadir on 24.11.2024.
//

import SwiftUI

struct ShimmerEffectView: View {
    @State private var shimmerPosition: CGFloat = -1.0
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.01))
                .frame(width: width, height: height)
                .cornerRadius(10)
            
            GeometryReader { geometry in
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.01), Color.white.opacity(0.02), Color.white.opacity(0.01)]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .frame(width: width, height: height)
                    .cornerRadius(10)
                    .offset(x: shimmerPosition * geometry.size.width)
                    .onAppear {
                        withAnimation(
                            Animation.easeOut(duration: 2.0)
                                .repeatForever(autoreverses: false)
                        ) {
                            shimmerPosition = 2.0
                        }
                    }
            }
            .mask(
                Rectangle()
                    .frame(width: width, height: height)
                    .cornerRadius(10)
            )
        }
    }
}
