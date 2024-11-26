//
//  AsyncImageView.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI

struct AsyncImageView: View {
    
    let url: String
    let width: CGFloat
    let height: CGFloat
    
    @State private var isLoading = false
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .frame(width: width, height: height)
                    .cornerRadius(10)
            case .failure(_):
                Image(.imageplaceholder)
                    .resizable()
                    .frame(width: width, height: height)
                    .cornerRadius(10)
            default:
                ShimmerEffectView(width: width, height: height)
                    .frame(width: width, height: height)
            }
        }
    }
}
