//  Created by Ky Nguyen

import UIKit

class BookInteraction {
    weak var controller: BooksController?
    init(controller: BooksController) {
        self.controller = controller
    }

    func getData() {
        loadCategories()
    }

    private func loadCategories() {
        GetCategoriesWorker(completion: { [weak self] categories in
            self?.didGetCategories(categories)
        }).execute()
    }

    private func didGetCategories(_ categories: [String]) {
        controller?.categories = categories
        getBooks()
    }

    private func getBooks() {
        GetAllBooksWorker { [weak self] books in
            self?.didGetBooks(books)
        }.execute()
    }

    private func didGetBooks(_ books: [Book]) {
        let booksByCategory = Dictionary(grouping: books, by: { $0.category })
        controller?.booksDatasource = booksByCategory
    }
}
