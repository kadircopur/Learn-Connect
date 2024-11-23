//
//  CourseService.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import Foundation
import CoreData

class CourseService {
    
    static let shared = CourseService()
    
    private init() {}
    
    func fetchCourses(completion: @escaping (Result<[Course], Error>) -> Void) {
        guard let url = URL(string: Router.CourseURL.rawValue) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonCourses = try decoder.decode([JSONCourse].self, from: data)
                let courses = jsonCourses.map { jsonCourse in
                    Course(
                        id: UUID(uuidString: jsonCourse.id) ?? UUID(),
                        name: jsonCourse.name ?? "Untitled Course",
                        instructorName: jsonCourse.instructorName ?? "Unknown Instructor",
                        thumbnailURL: jsonCourse.thumbnailURL,
                        videoURL: jsonCourse.videoURL,
                        detail: jsonCourse.detail ?? "No details available.",
                        content: jsonCourse.content ?? "No content available.",
                        duration: jsonCourse.duration)
                }
                completion(.success(courses))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
