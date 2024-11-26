//
//  VideoPlayerManager.swift
//  Learn Connect
//
//  Created by kadir on 24.11.2024.
//

import Foundation
import AVKit

class VideoPlayerManager {
    static let shared = VideoPlayerManager()
    private var players: [URL: AVPlayer] = [:]

    func getPlayer(for url: URL) -> AVPlayer {
        if let player = players[url] {
            return player
        } else {
            let newPlayer = AVPlayer(url: url)
            players[url] = newPlayer
            return newPlayer
        }
    }
}
