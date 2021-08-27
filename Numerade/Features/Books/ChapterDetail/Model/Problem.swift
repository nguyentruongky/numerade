//  Created by Ky Nguyen

import UIKit

struct Problem: Codable {
    var id = UUID().uuidString
    let imageUrl: String?
    let order: Int
    let teacherImageUrl: String
    let teacherName: String
    let content: String
}
