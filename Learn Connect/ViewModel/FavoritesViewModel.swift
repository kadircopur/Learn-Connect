//
//  FavoritesViewModel.swift
//  Learn Connect
//
//  Created by kadir on 25.11.2024.
//

import Foundation
import Observation

@MainActor
@Observable
class FavoritesViewModel {
    private let persistenceService = PersistenceService.shared
    private let authService = AuthService.shared
    private var user: User? = nil
    
    var courses: [UserCourse] = []
    
    init() {
        setUser()
        fetchFavoriteCourses()
    }
    
    func setUser() {
        guard let userEmail = getUserEmail() else { return }
        user = persistenceService.fetchUserByEmail(email: userEmail)
    }
    
    func fetchFavoriteCourses() {
        if let user = user {
            courses = user.courses.filter{ $0.isFavourite }
        }
    }
    
    func handleDeleteAction(offsets: IndexSet) {
        guard let user = user else { return }
        
        offsets.forEach { index in
            let course = courses[index]
            courses.remove(at: index)
            user.courses.first(where: { $0.id == course.id })?.isFavourite = false
        }
        
        persistenceService.updateUser(user: user)
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
