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
    private let authService = AuthService.shared
    private var user: User? = nil

    var course: Course
    var isFavorite: Bool = false
    var isAttended: Bool = false

    init(course: Course) {
        self.course = course
        getUser()
        setCourseStatus()
    }
    
    private func getUser() {
        guard let userEmail = getUserEmail() else { return }
        user = persistanceService.fetchUserByEmail(email: userEmail)
        
        if let user = user,
           !user.courses.contains(where: { $0.id == course.id }) {
            user.courses.append(UserCourse.from(course: course))
            persistanceService.updateUser(user: user)
        }
    }
    
    private func setCourseStatus() {
        if let user = user,
           let course =  user.courses.first(where: { $0.id == course.id }){
            isAttended = course.isAttended
            isFavorite = course.isFavourite
        }
    }
    
    func handleAttendAction() {
        guard let user = user else { return }
        
        if !isAttended {
            user.courses.first(where: { $0.id == course.id })?.isAttended = true
            persistanceService.updateUser(user: user)
            isAttended = true
        }
    }
    
    func handleFavoriteAction() {
        guard let user = user else { return }
        
        switch isFavorite {
        case true:
            user.courses.first(where: { $0.id == course.id })?.isFavourite = false
        case false:
            user.courses.first(where: { $0.id == course.id })?.isFavourite = true
        }
        
        isFavorite.toggle()
        persistanceService.updateUser(user: user)
    }
    
    private func getUserEmail() -> String? {
        switch authService.currentUserEmail() {
        case .success(let email):
            return email
        case .failure(let failure):
            return nil
        }
    }
}
