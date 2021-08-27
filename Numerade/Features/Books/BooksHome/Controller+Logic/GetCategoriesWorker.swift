//  Created by Ky Nguyen

import Foundation
struct GetCategoriesWorker {
    let completion: ([String]) -> Void
    func execute() {
        loadLocally()
    }

    private func loadLocally() {
        let categories = [
            "All",
            "Physics",
            "Math",
            "Chemistry",
            "Biology",
            "Economics",
            "Psychology"
        ]
        completion(categories)
    }
}
