//
//  CourseDetailViewModel.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import Foundation
import Observation

@MainActor
@Observable
class CourseDetailViewModel {
    
    private let persistanceService = PersistenceService.shared
    private var user: User? = nil

    var course: Course
    var isAttended: Bool = false
    
    init(course: Course) {
        self.course = course
        getUser()
        setCourseStatus()
    }
    
    private func getUser() {
        let userEmail = getUserEmail()
        user = persistanceService.fetchUserByEmail(email: userEmail)
    }
    
    private func setCourseStatus() {
        isAttended = ((user?.attendedCourses.contains(where: { $0.id == course.id } )) != nil)
    }
    
    func handleAttendAction() {
        if !isAttended,
            let user = user {
            user.attendedCourses.append(course)
            persistanceService.updateUser(user: user)
            isAttended = true
        }
    }
    
    func getUserEmail() -> String {
        return "kadir@gmail.com"
    }
}
