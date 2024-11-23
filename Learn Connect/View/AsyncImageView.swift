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
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .frame(width: width, height: height)
                    .cornerRadius(10)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .clipped()
            case .success(let image):
                image
                    .resizable()
                    .frame(width: width, height: height)
                    .cornerRadius(10)
            case .failure(let error):
                Text("Couldn't load: \(error.localizedDescription)")
            @unknown default:
                fatalError()
            }
        }
    }
}
