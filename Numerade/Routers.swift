//  Created by Ky Nguyen

import UIKit

enum Destination {
    case bookDetail(book: Book)
    case chapterDetail(book: Book?, chapter: Chapter)
    case problemDetail(book: Book?, chapter: Chapter?, problem: Problem)
}

extension UIViewController {
    func push(to destination: Destination) {
        switch destination {
            case .bookDetail(let book):
                let vc = BookDetailController()
                vc.book = book
                navigationController?.pushViewController(vc, animated: true)
            
            case .chapterDetail(let book, let chapter):
                let vc = ChapterDetailController()
                vc.book = book
                vc.chapter = chapter
                navigationController?.pushViewController(vc, animated: true)

            default:
                break
        }
    }
    
    func present(destination: Destination) {
        switch destination {
            case .problemDetail(let book, let chapter, let problem):
                let vc = ProblemDetailController()
                vc.book = book
                vc.chapter = chapter
                vc.problem = problem
                present(vc, animated: true)

            default:
                break
        }
    }
}
