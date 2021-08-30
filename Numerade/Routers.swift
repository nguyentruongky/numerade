//  Created by Ky Nguyen

import UIKit

enum Destination {
    case bookDetail(book: Book)
    case chapterDetail(book: Book?, chapter: Chapter)
    case problemDetail(book: Book?, chapter: Chapter?, problem: Problem)
}

enum PresentType {
    case present, push
}

extension UIViewController {
    func push(to destination: Destination) {
        show(presentType: .push, destination: destination)
    }

    func present(destination: Destination) {
        show(presentType: .present, destination: destination)
    }

    private func show(presentType: PresentType = .push, destination: Destination) {
        switch destination {
            case .bookDetail(let book):
                let vc = BookDetailController()
                vc.book = book
                show(presentType: presentType, screen: vc)

            case .chapterDetail(let book, let chapter):
                let vc = ChapterDetailController()
                vc.book = book
                vc.chapter = chapter
                show(presentType: presentType, screen: vc)

            case .problemDetail(let book, let chapter, let problem):
                let vc = ProblemDetailController()
                vc.book = book
                vc.chapter = chapter
                vc.problem = problem
                show(presentType: presentType, screen: vc)
        }
    }

    private func show(presentType: PresentType, screen: UIViewController) {
        switch presentType {
            case .present:
                present(screen, animated: true)
            case .push:
                navigationController?.pushViewController(screen, animated: true)
        }
    }
}
