//  Created by Ky Nguyen

import Foundation

struct Book: Codable {
    let id: String
    let coverImageUrl: String
    let edition: String
    let title: String
    let questionCount: Int
    let category: String
}
