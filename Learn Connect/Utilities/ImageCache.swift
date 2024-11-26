//
//  ImageCache.swift
//  Learn Connect
//
//  Created by kadir on 24.11.2024.
//

import SwiftUI
import Combine

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSURL, UIImage>()

    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func saveImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
