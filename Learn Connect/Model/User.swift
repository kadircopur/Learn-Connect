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
    var name: String
    var surname: String
    var courses: [UserCourse] = []

    init(email: String, name: String = "Abdulkadir", surname: String = "Çopur") {
        self.email = email
        self.name = name
        self.surname = surname
    }
}
