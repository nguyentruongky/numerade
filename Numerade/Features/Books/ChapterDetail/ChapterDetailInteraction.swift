//  Created by Ky Nguyen

import UIKit

class ChapterDetailInteraction {
    weak var controller: ChapterDetailController?
    init(controller: ChapterDetailController) {
        self.controller = controller
    }
    
    func getData() {
        guard let chapter = controller?.chapter else { return }
        GetChapterDetailWorker(chapter: chapter, onSuccess: { [weak self] detail in
            self?.controller?.setDataToUI(detail)
        }, onFailure: { [weak self] error in
            self?.controller?.showErrorMessage(error.localizedDescription)
        }).execute()
    }
}
