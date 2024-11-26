//
//  PersistenceService.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import SwiftData
import Observation
import SwiftUI

@MainActor
class PersistenceService {
    
    static let shared = PersistenceService()
    
    private let modelContext: ModelContext
    
    private init() {
        do {
            let container = try ModelContainer(for: User.self, UserCourse.self)
            self.modelContext = container.mainContext
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error.localizedDescription)")
        }
        
        if let storeURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            print("Database Location: \(storeURL)")
        }
    }
    
    // MARK: - User CRUD
    
    func createUser(email: String) -> User {
        let user = User(email: email)
        modelContext.insert(user)
        saveChanges()
        return user
    }
    
    func fetchAllUsers() -> [User] {
        let fetchRequest = FetchDescriptor<User>()
        return (try? modelContext.fetch(fetchRequest)) ?? []
    }
    
    func fetchUserByEmail(email: String) -> User? {
        let fetchRequest = FetchDescriptor<User>(
            predicate: #Predicate { $0.email == email }
        )
        return try? modelContext.fetch(fetchRequest).first
    }
    
    func updateUser(user: User, email: String? = nil, courses: [UserCourse]? = nil) {
        if let courses = courses {
            user.courses = courses
        }
        saveChanges()
    }
    
    func deleteUser(user: User) {
        modelContext.delete(user)
        saveChanges()
    }
    
    // MARK: - Helper Methods
    
    private func saveChanges() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
}
