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
            let container = try ModelContainer(for: User.self, Course.self)
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
    
    func updateUser(user: User, email: String? = nil, attendedCourses: [Course]? = nil, favouriteCourses: [Course]? = nil) {
        if let email = email {
            user.email = email
        }
        if let attendedCourses = attendedCourses {
            user.attendedCourses = attendedCourses
        }
        if let favouriteCourses = favouriteCourses {
            user.favouriteCourses = favouriteCourses
        }
        saveChanges()
    }
    
    func deleteUser(user: User) {
        modelContext.delete(user)
        saveChanges()
    }
    
    // MARK: - Course CRUD
    
    func createCourse(name: String, instructorName: String, thumbnailURL: String, videoURL: String, detail: String, content: String, duration: String) -> Course {
        let course = Course(
            id: UUID(),
            name: name,
            instructorName: instructorName,
            thumbnailURL: thumbnailURL,
            videoURL: videoURL,
            detail: detail,
            content: content,
            duration: duration
        )
        modelContext.insert(course)
        saveChanges()
        return course
    }
    
    func fetchAllCourses() -> [Course] {
        let fetchRequest = FetchDescriptor<Course>()
        return (try? modelContext.fetch(fetchRequest)) ?? []
    }
    
    func updateCourse(course: Course, name: String? = nil, instructorName: String? = nil, thumbnailURL: String? = nil, videoURL: String? = nil, detail: String? = nil, content: String? = nil, duration: String? = nil, watchedDuration: String? = nil) {
        if let name = name {
            course.name = name
        }
        if let instructorName = instructorName {
            course.instructorName = instructorName
        }
        if let thumbnailURL = thumbnailURL {
            course.thumbnailURL = thumbnailURL
        }
        if let videoURL = videoURL {
            course.videoURL = videoURL
        }
        if let detail = detail {
            course.detail = detail
        }
        if let content = content {
            course.content = content
        }
        if let duration = duration {
            course.duration = duration
        }
        if let watchedDuration = watchedDuration {
            course.watchedDuration = watchedDuration
        }
        saveChanges()
    }
    
    func deleteCourse(course: Course) {
        modelContext.delete(course)
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
