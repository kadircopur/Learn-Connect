//
//  AsyncImageView.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI

struct CachedAsyncImageView: View {
    let url: String
    let width: CGFloat
    let height: CGFloat
    let placeholder: Image
    let cornerRadius: CGFloat
    
    @State private var image: UIImage? = nil
    @State private var isLoading = false
    
    var body: some View {
        Group {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
            } else if isLoading {
                ShimmerEffectView(width: width, height: height)
                    .frame(width: width, height: height)
            } else {
                placeholder
                    .resizable()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        
        guard let url = URL(string: url) else { return }
        
        if let cachedImage = ImageCache.shared.getImage(for: url) {
            self.image = cachedImage
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            isLoading = false
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("Image download failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            ImageCache.shared.saveImage(downloadedImage, for: url)
            
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }.resume()
    }
}
