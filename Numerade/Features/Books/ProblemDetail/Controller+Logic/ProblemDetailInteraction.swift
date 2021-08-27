//  Created by Ky Nguyen

import UIKit

class ProblemDetailInteraction {
    weak var controller: ProblemDetailController?
    init(controller: ProblemDetailController) {
        self.controller = controller
    }
    
    func getData() {
        guard let book = controller?.book,
              let chapter = controller?.chapter,
              let problem = controller?.problem else { return }
        GetProblemDetailWorker(book: book, chapter: chapter, problem: problem, onSuccess: { [weak self] detail in
            self?.controller?.setDataToUI(detail)
        }, onFailure: { error in
            self.controller?.showErrorMessage(error.localizedDescription)
        }).execute()
    }
}
