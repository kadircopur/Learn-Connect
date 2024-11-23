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
    var areCoursesLoading = false
    
    init() { fetchCourses() }
    
    func fetchCourses() {
        areCoursesLoading = true
        
        courseService.fetchCourses { [weak self] result in
            self?.areCoursesLoading = false
            switch result {
            case .success(let courses):
                self?.courses = courses
            case .failure(let failure):
                print("An error occured: \(failure.localizedDescription)")
            }
        }
    }
}
