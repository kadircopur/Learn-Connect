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
                let courses = try decoder.decode([Course].self, from: data)
                completion(.success(courses))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
