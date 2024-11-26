//
//  CoursesViewModel.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import Foundation
import Observation

@Observable
class CoursesViewModel {
    
    private let courseService = CourseService.shared
    
    var courses: [Course] = []
    
    init() { fetchCourses() }
    
    func fetchCourses() {
        courseService.fetchCourses { [weak self] result in
            switch result {
            case .success(let courses):
                self?.courses = courses
            case .failure(let failure):
                print("An error occured: \(failure.localizedDescription)")
            }
        }
    }
}
