//  Created by Ky Nguyen

import UIKit

class ProblemDetailController: KNController {
    override var shouldGetDataViewDidLoad: Bool { true }
    
    private lazy var interaction = ProblemDetailInteraction(controller: self)
    var problem: Problem?
    var chapter: Chapter?
    var book: Book?
    
    private let ui = ProblemDetailUI()

    override func setupView() {
        ui.setupView(view)
        ui.closeButton.addTarget(self, action: #selector(dismissScreen))
    }
    
    override func getData() {
        interaction.getData()
    }
    
    @objc func dismissScreen() {
        dismiss(animated: true)
    }
}

extension ProblemDetailController {
    func setDataToUI(_ data: ProblemDetail) {
        ui.setDataToUI(data)
    }
}
