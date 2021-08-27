//  Created by Ky Nguyen

import UIKit

class BookDetailInteraction {
    weak var controller: BookDetailController?
    init(controller: BookDetailController) {
        self.controller = controller
    }
    
    func getData() {
        guard let book = controller?.book else { return }
        GetBookDetailWorker(book: book, onSuccess: { [weak self] detail in
            self?.controller?.setDataToUI(bookDetail: detail)
        }, onFailure: { error in
            self.controller?.showErrorMessage(error.localizedDescription)
        }).execute()
    }
}
