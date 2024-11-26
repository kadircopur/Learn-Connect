//
//  ContentViewModel.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import Foundation
import Observation

@MainActor
@Observable
class ContentViewModel {
    private let persistenceService = PersistenceService.shared
    private let authService = AuthService.shared
    
    init() {
        _ = createOrGetUser()
    }
    
    func createOrGetUser() -> User? {
        guard let userEmail = getUserEmail() else { return nil }
        
        if let user = persistenceService.fetchUserByEmail(email: userEmail) {
            return user
        }
        
        return persistenceService.createUser(email: userEmail)
    }
    
    private func getUserEmail() -> String? {
        switch authService.currentUserEmail() {
        case .success(let email):
            return email
        case .failure(_):
            return nil
        }
    }
}
