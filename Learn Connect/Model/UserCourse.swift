//
//  UserCourse.swift
//  Learn Connect
//
//  Created by kadir on 25.11.2024.
//

import Foundation
import SwiftData

@Model
class UserCourse: Identifiable {
    @Attribute(.unique) var id: String
    var name: String
    var instructorName: String
    var thumbnailURL: String
    var videoURL: String
    var detail: String
    var content: String
    var duration: String
    var watchedDuration: String?
    var isFavourite: Bool
    var isAttended: Bool

    init(
        id: String = "",
        name: String = "Untitled Course",
        instructorName: String = "Unknown Instructor",
        thumbnailURL: String = "",
        videoURL: String = "",
        detail: String = "No details available.",
        content: String = "No content available.",
        duration: String = "",
        watchedDuration: String? = "00:00",
        isFavourite: Bool = false,
        isAttended: Bool = false
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
        self.isFavourite = isFavourite
        self.isAttended = isAttended
    }
}

extension UserCourse {
    static func from(course: Course) -> UserCourse {
        return UserCourse(
            id: course.id,
            name: course.name ?? "Untitled Course",
            instructorName: course.instructorName ?? "Unknown Instructor",
            thumbnailURL: course.thumbnailURL,
            videoURL: course.videoURL,
            detail: course.detail ?? "No details available.",
            content: course.content ?? "No content available.",
            duration: course.duration
        )
    }
}
