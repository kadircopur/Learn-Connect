//
//  MyCoursesViewModel.swift
//  Learn Connect
//
//  Created by kadir on 23.11.2024.
//

import Foundation
import Observation

@MainActor
@Observable
class MyCoursesViewModel {
    
    private let persistanceService = PersistenceService.shared
    private let authService = AuthService.shared
    private var user: User? = nil
    
    var courses: [UserCourse] = []
    
    init() {
        setUser()
        fetchAttendedCourses()
    }
    
    func setUser() {
        guard let userEmail = getUserEmail() else { return }
        user = persistanceService.fetchUserByEmail(email: userEmail)
    }
    
    func fetchAttendedCourses() {
        if let user = user {
            courses = user.courses.filter{ $0.isAttended }
        }
    }
    
    private func getUserEmail() -> String? {
        switch authService.currentUserEmail() {
        case .success(let email):
            return email
        case .failure(let failure):
            return nil
        }
    }
    
    func getRateOfProgress(for course: UserCourse) -> Int {
        guard let user = user,
              let watchedDuration = user.courses.first(where: { $0.id == course.id })?.watchedDuration
        else { return 0 }
        
        return calculateProgress(watchedDuration: watchedDuration, totalDuration: course.duration)
    }
    
    private func calculateProgress(watchedDuration: String, totalDuration: String) -> Int {
            let watchedSeconds = parseDuration(watchedDuration)
            let totalSeconds = parseDuration(totalDuration)
            guard totalSeconds > 0 else { return 0 }
            let progress = (watchedSeconds / totalSeconds) * 100
            return Int(progress)
    }
    
    private func parseDuration(_ duration: String) -> Double {
        let components = duration.split(separator: ":").map { Int($0) ?? 0 }
        let seconds = components.reversed().enumerated().reduce(0) { total, part in
            total + part.element * Int(pow(60.0, Double(part.offset)))
        }
        return Double(seconds)
    }
}
