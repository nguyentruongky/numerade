//  Created by Ky Nguyen

import UIKit

class ProblemDetailController: KNController {
    static func presented(from source: UIViewController, book: Book?, chapter: Chapter?, problem: Problem) {
        let vc = ProblemDetailController()
        vc.book = book
        vc.chapter = chapter
        vc.problem = problem
        source.present(vc, animated: true)
    }
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
