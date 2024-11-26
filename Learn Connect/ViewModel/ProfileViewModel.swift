//
//  ProfileViewModel.swift
//  Learn Connect
//
//  Created by kadir on 25.11.2024.
//

import Foundation
import Observation


@MainActor
@Observable
class ProfileViewModel {
    private let persistenceService = PersistenceService.shared
    private let authService = AuthService.shared
    private var user: User? = nil
    
    var isDarkMode = false
    var isLoggedOut = false
    
    init() {
        getUser()
    }
    
    func getUser() {
        if let userEmail = getUserEmail() {
            user = persistenceService.fetchUserByEmail(email: userEmail)
        }
    }
    
    func getUserName() -> String {
        switch authService.currentUserName() {
        case .success(let username):
            return username
        case .failure(_):
            return "Unknown username"
        }
    }
        
    func getUserEmail() -> String? {
        switch authService.currentUserEmail() {
        case .success(let email):
            return email
        case .failure(_):
            return nil
        }
    }
    
    func logOut() {
        authService.logout { [weak self] result in
            switch result {
            case .success(_):
                self?.isLoggedOut = true
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
