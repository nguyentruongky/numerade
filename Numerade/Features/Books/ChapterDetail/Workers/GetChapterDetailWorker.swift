//  Created by Ky Nguyen

import UIKit

struct GetChapterDetailWorker {
    let chapter: Chapter
    let onSuccess: (ChapterDetail) -> Void
    let onFailure: (Error) -> Void
    
    func execute() {
        runLocally()
    }
    
    private func runLocally() {
        let problems = Dataset.getChapterDetail(chapterId: chapter.id)
        let detail = ChapterDetail(chapter: chapter, problems: problems)
        onSuccess(detail)
    }
}
