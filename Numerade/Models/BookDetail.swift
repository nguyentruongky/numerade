//  Created by Ky Nguyen

import UIKit

struct Chapter: Codable {
    var id = UUID().uuidString
    let order: Int
    let title: String
    let questionCount: Int
    let teachers: [String]
}

struct BookDetail: Codable {
    let id: String
    let coverImageUrl: String
    let edition: String
    let title: String
    let questionCount: Int
    let category: String
    let chapters: [Chapter]
}
