//  Created by Ky Nguyen

import UIKit

struct GetBookDetailWorker {
    let book: Book
    let onSuccess: (BookDetail) -> Void
    let onFailure: (Error) -> Void

    func execute() {
        runLocally()
    }

    func runLocally() {
        let detail = Dataset.getBook(book: book)
        onSuccess(detail)
    }
}
