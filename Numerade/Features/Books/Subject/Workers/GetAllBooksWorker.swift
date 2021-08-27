//  Created by Ky Nguyen

import Foundation

struct GetAllBooksWorker {
    let completion: ([Book]) -> Void

    func execute() {
        loadLocally()
    }
    
    private func loadLocally() {
        guard let path = Bundle.main.path(forResource: "books", ofType: "json") else {
            completion([])
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let books = try JSONDecoder().decode([Book].self, from: data)
            completion(books)
        } catch let error {
            print(error)
            completion([])
        }
    }
}
