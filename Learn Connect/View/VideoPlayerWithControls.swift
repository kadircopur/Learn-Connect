//
//  VideoPlayerWithControls.swift
//  Learn Connect
//
//  Created by kadir on 24.11.2024.
//


import SwiftUI
import AVKit

struct VideoPlayerWithOverlayControls: View {
    @Bindable var viewModel: AttendedCourseViewModel
    @State private var player: AVPlayer
    @State private var isPlaying: Bool = false
    
    private var videoURL: URL
    private var videoPlayerManager = VideoPlayerManager.shared
    
    var lastDuration: CMTime?
    var height: CGFloat
    
    init(videoURL: URL, viewModel: AttendedCourseViewModel, lastDuration: CMTime? = nil, height: CGFloat = 0) {
        _player = State(initialValue: videoPlayerManager.getPlayer(for: videoURL))
        self._viewModel = Bindable(viewModel)
        self.lastDuration = lastDuration
        self.height = height
        self.videoURL = videoURL
    }
    
    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .onAppear {
                    if let watchedDuration = lastDuration, watchedDuration != .zero {
                        let asset = AVURLAsset(url: videoURL)
                        Task {
                            do {
                                let isPlayable = try await asset.load(.isPlayable)
                                if isPlayable {
                                    let playerItem = AVPlayerItem(asset: asset)
                                    DispatchQueue.main.async {
                                        self.player.replaceCurrentItem(with: playerItem)
                                        self.player.seek(to: watchedDuration)
                                    }
                                } else {
                                    print("Asset is not playable.")
                                }
                            } catch {
                                print("Failed to load asset property: \(error.localizedDescription)")
                            }
                        }
                    }
                }
                .onDisappear {
                    let currentTime = player.currentTime()
                    viewModel.updateWatchedDuration(newDuration: currentTime)
                    player.pause()
                    player.replaceCurrentItem(with: nil)
                }
                .frame(height: height)
        }
    }
}
