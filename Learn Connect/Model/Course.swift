//
//  Course.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import Foundation

struct Course: Codable {
    let id: String
    let name: String?
    let instructorName: String?
    let thumbnailURL: String
    let videoURL: String
    let detail: String?
    let content: String?
    let duration: String
}
