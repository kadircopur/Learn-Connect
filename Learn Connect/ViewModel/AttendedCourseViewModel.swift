//
//  AttendedCourseViewModel.swift
//  Learn Connect
//
//  Created by kadir on 24.11.2024.
//

import Foundation
import Observation
import AVFoundation

@MainActor
@Observable
class AttendedCourseViewModel {
    private let persistenceService = PersistenceService.shared
    private let authService = AuthService.shared
    private var user: User? = nil
    private var isCourseCancelled = false
    
    var course: UserCourse
    var watchedDuration: String? = nil
    
    init(course: UserCourse) {
        self.course = course
        getUser()
    }
    
    func getVideoURL() -> URL {
        if let url = URL(string: course.videoURL) {
            return url
        }
        
        return URL(fileURLWithPath: "")
    }
    
    func getWatchedDuration() -> CMTime? {
        if let user = user,
           let duration = user.courses.first(where: { $0.id == course.id })?.watchedDuration {
             return parseTime(duration)
        }
        return nil
    }
    
    func cancelCourse() {
        guard let user = user else { return }

        user.courses.first(where: { $0.id == course.id })?.isAttended = false
        user.courses.first(where: { $0.id == course.id })?.watchedDuration = "00:00"
        persistenceService.updateUser(user: user)
        
        isCourseCancelled = true
    }
    
    func updateWatchedDuration(newDuration: CMTime) {
        
        guard let user = user,
            !isCourseCancelled else {
            return
        }
        
        let durationString = formatTime(newDuration)
        
        if let existingDuration = user.courses.first(where: { $0.id == course.id }) {
            existingDuration.watchedDuration = durationString
        }
        
        persistenceService.updateUser(user: user)
    }
    
    private func getUser() {
        guard let userEmail = getUserEmail() else { return }
        user = persistenceService.fetchUserByEmail(email: userEmail)
    }
    
    private func getUserEmail() -> String? {
        switch authService.currentUserEmail() {
        case .success(let email):
            return email
        case .failure(let failure):
            return nil
        }
    }

    
    private func formatTime(_ time: CMTime) -> String {
        let totalSeconds = Int(CMTimeGetSeconds(time))
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func parseTime(_ timeString: String) -> CMTime {
        let components = timeString.split(separator: ":").map { Int($0) ?? 0 }
        guard components.count == 3 else { return .zero }
        let seconds = components[0] * 3600 + components[1] * 60 + components[2]
        return CMTime(seconds: Double(seconds), preferredTimescale: 600)
    }
}

