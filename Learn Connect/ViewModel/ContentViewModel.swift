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
    var userEmail: String = "kadir@gmail.com"
    var persistenceService = PersistenceService.shared
    
    func createOrGetUser() -> User {
        if let user = persistenceService.fetchUserByEmail(email: userEmail) {
            return user
        }
        
        return persistenceService.createUser(email: userEmail)
    }
}
