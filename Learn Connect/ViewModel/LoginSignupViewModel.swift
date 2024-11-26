//
//  LoginSignupViewModel.swift
//  Learn Connect
//
//  Created by kadir on 26.11.2024.
//

import Foundation
import Observation

@MainActor
@Observable
class LoginSignupViewModel {
    
    /// Input Fields
    var email: String = ""
    var password: String = "" {
        didSet {
            validatePassword()
        }
    }
    
    var confirmPassword: String = ""
    var username: String = ""
    
    /// Error Messages and Validation
    var errorMessage: String = ""
    var isPasswordValid: Bool = false
    var isSignupMode: Bool = false
    var isLoading: Bool = false
    var isAuthenticated: Bool = false

    private let authService = AuthService.shared
    private let persistenceService = PersistenceService.shared
        
    func toggleMode() {
        isSignupMode.toggle()
        clearFields()
    }
    
    private func clearFields() {
        email = ""
        password = ""
        confirmPassword = ""
        errorMessage = ""
        username = ""
    }
    
    @MainActor
    func handleAction() {
        guard isPasswordValid else {
            errorMessage = "Please enter a valid password."
            return
        }
        
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid e-mail adress."
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        if isSignupMode {
            signUp(email: email, password: password, username: username)
        } else {
            signIn(email: email, password: password)
        }
    }
    
    private func signUp(email: String, password: String, username: String) {
        isLoading = true
        
        if password != confirmPassword {
            self.errorMessage = "Passwords do not match."
            self.isLoading = false
            return
        }
        
        authService.signUp(userEmail: email, password: password, username: username) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let success):
                self?.isAuthenticated = true
                print(success)
            case .failure(let failure):
                self?.errorMessage = failure.localizedDescription
            }
        }
    }

    private func signIn(email: String, password: String) {
        isLoading = true
        
        authService.signIn(userEmail: email, password: password) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let success):
                self?.isAuthenticated = true
                print(success)
            case .failure(let failure):
                self?.errorMessage = failure.localizedDescription
            }
        }
    }
    
    private func validatePassword() {
        let passwordCriteria = [
            password.count >= 8, // Minimum 8 characters
            password.rangeOfCharacter(from: .uppercaseLetters) != nil, // At least 1 uppercase letter
            password.rangeOfCharacter(from: .lowercaseLetters) != nil, // At least 1 lowercase letter
            password.rangeOfCharacter(from: .decimalDigits) != nil, // At least 1 digit
            password.rangeOfCharacter(from: .punctuationCharacters) != nil // At least 1 special character
        ]
        
        if passwordCriteria.allSatisfy({ $0 }) {
            errorMessage = ""
            isPasswordValid = true
        } else {
            errorMessage = """
                Password must be at least 8 characters long,
                1 capital letter,
                1 lowercase letter,
                It must contain 1 number and 1 special character.
                """
            isPasswordValid = false
        }
    }
    
    // Validate email
    private func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}





