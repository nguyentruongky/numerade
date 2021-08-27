//  Created by Ky Nguyen

import UIKit

class Dataset {
    static var books = [String: BookDetail]()

    static func getBook(book: Book) -> BookDetail {
        if let bookDetail = books[book.id] {
            return bookDetail
        }

        let chapterCount = Int.random(in: 5...10)
        var chapters = [Chapter]()

        for i in 0 ..< chapterCount {
            let chapter = Chapter(order: i + 1,
                                  title: getOneChapterTitle(),
                                  questionCount: getRandomQuestionCount(),
                                  teachers: getTeachers())
            chapters.append(chapter)
        }

        let bookDetail = BookDetail(
            id: book.id,
            coverImageUrl: book.coverImageUrl,
            edition: book.edition,
            title: book.title,
            questionCount: book.questionCount,
            category: book.category, chapters: chapters)
        books[book.id] = bookDetail
        return bookDetail
    }
    
    private static let chapterTitles = [
        "The Lemonade War",
        "Sideways Arithmetic From Wayside School",
        "7 x 9 = Trouble!",
        "Fractions = Trouble!",
        "Early Chapter Book Series about Boys",
        "The Candy Corn Contest",
        "The Toothpaste Millionaire",
        "The Math Wiz",
        "The Phantom Tollbooth",
        "The Number Devil: A Mathematical Adventure",
        "The Adventures of Penrose the Mathematical Cat",
        "Further Adventures of Penrose the Mathematical Cat",
        "Fractals, Googols, and Other Mathematical Tales",
        "The Man Who Counted: A Collection of Mathematical Adventures"
    ]
    private static let teachers = [
        "https://img.buzzfeed.com/buzzfeed-static/static/2019-08/5/16/asset/33f61b1366af/sub-buzz-885-1565023603-2.jpg?crop=683%3A1024%3B0%2C0&downsize=900:*&output-format=auto&output-quality=auto",
        "https://gumlet.assettype.com/freepressjournal/import/2017/10/Tom-Cruise.jpg?w=400&dpr=2.6",
        "https://i.imgur.com/stVr12G.jpg",
        "https://thumb-p5.xhcdn.com/a/-gGXHl4pyVO-ATFfbfkkBA/000/097/880/415_450.jpg",
        "https://pickytop.com/wp-content/uploads/2020/03/Gal-Gadot.jpg",
        "https://media.vanityfair.com/photos/599c55ff09805938f04c9076/2:3/w_639,h_959,c_limit/hollywood-highest-paid-actor-actress.jpg",
        "https://www.wonderslist.com/wp-content/uploads/2017/02/Robert-Downey-Jr.-Never-Won-An-Oscar.jpg",
        "https://cdn.wallpapersafari.com/29/21/VDpA2Y.jpg"
    ]
    static func getOneChapterTitle() -> String {
        return chapterTitles.randomElement()!
    }
    static func getRandomQuestionCount() -> Int {
        return Int.random(in: 100...3000)
    }
    static func getOneTeacher() -> String {
        return teachers.randomElement()!
    }
    static func getTeachers() -> [String] {
        let teachersCount = Int.random(in: 1 ... 3)
        var teachers = [String]()
        for _ in 0 ..< teachersCount {
            teachers.append(getOneTeacher())
        }
        return teachers
    }
}
