//  Created by Ky Nguyen

import UIKit

struct GetProblemDetailWorker {
    let book: Book
    let chapter: Chapter
    let problem: Problem
    let onSuccess: (ProblemDetail) -> Void
    let onFailure: (Error) -> Void
    
    func execute() {
        runLocally()
    }
    
    func runLocally() {
        let detail = Dataset.getProblemDetail(book: book, chapter: chapter, problem: problem)
        onSuccess(detail)
    }
}
