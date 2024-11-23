//
//  User.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import Foundation
import Observation
import SwiftData

@Model
class User: Identifiable {
    @Attribute(.unique) var email: String
    var attendedCourses: [Course] = []
    var favouriteCourses: [Course] = []
    
    init(email: String) {
        self.email = email
    }
}
