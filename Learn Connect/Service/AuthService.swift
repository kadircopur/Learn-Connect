//
//  AuthService.swift
//  Learn Connect
//
//  Created by kadir on 26.11.2024.
//

import Foundation
import Observation
import FirebaseAuth


@Observable
class AuthService {
    static let shared = AuthService() // Singleton
    
    private init() {} // Private initializer to prevent external instantiation
    
    var isLoading = false
    
    // MARK: - User CRUD
    
    func signIn(userEmail email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success("User signed in: \(authResult?.user.email ?? "No Email")"))
                }
            }
        }
    }
    
    func signUp(userEmail email: String, password: String, username: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let user = authResult?.user else {
                    let error = NSError(domain: "SignUpError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create user"])
                    completion(.failure(error))
                    return
                }
                
                Auth.auth().currentUser?.displayName = username
                completion(.success("User signed up: \(user.email ?? "No Email")"))
            }
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            print("User did log out")
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    /// Returns the current user's email if authenticated
    func currentUserEmail() -> Result<String, Error> {
        if let email = Auth.auth().currentUser?.email {
            return .success(email)
        } else {
            return .failure(NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "No user is currently signed in."]))
        }
    }
    /// Returns the current user's name if authenticated
    func currentUserName() -> Result<String, Error> {
        if let name = Auth.auth().currentUser?.displayName {
            return .success(name)
        } else {
            return .failure(NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "No user is currently signed in."]))
        }
    }
}


