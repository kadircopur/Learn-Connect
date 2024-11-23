//
//  Course.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import Foundation
import Observation
import SwiftData

@Model
class Course: Identifiable {
    var id: UUID
    var name: String
    var instructorName: String
    var thumbnailURL: String
    var videoURL: String
    var detail: String
    var content: String
    var duration: String
    var watchedDuration: String?

    init(
        id: UUID = UUID(),
        name: String = "Untitled Course",
        instructorName: String = "Unknown Instructor",
        thumbnailURL: String = "",
        videoURL: String = "",
        detail: String = "No details available.",
        content: String = "No content available.",
        duration: String = "",
        watchedDuration: String? = nil
    ) {
        self.id = id
        self.name = name
        self.instructorName = instructorName
        self.thumbnailURL = thumbnailURL
        self.videoURL = videoURL
        self.detail = detail
        self.content = content
        self.duration = duration
        self.watchedDuration = watchedDuration
    }
}


struct JSONCourse: Codable {
    let id: String
    let name: String?
    let instructorName: String?
    let thumbnailURL: String
    let videoURL: String
    let detail: String?
    let content: String?
    let duration: String
}
