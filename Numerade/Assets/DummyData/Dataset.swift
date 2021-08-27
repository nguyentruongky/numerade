//  Created by Ky Nguyen

import UIKit

class Dataset {
    static var books = [String: BookDetail]()
    static var chapters = [String: [Problem]]()

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
    
    static func getChapterDetail(chapterId: String) -> [Problem] {
        if let detail = chapters[chapterId] {
            return detail
        }
        
        let problemCount = Int.random(in: 5...10)
        var problems = [Problem]()
        
        for i in 0 ..< problemCount {
            let chapter = Problem(imageUrl: problemImages.randomElement()!,
                                  order: i + 1,
                                  teacherImageUrl: teachers.randomElement()!,
                                  teacherName: teacherNames.randomElement()!,
                                  content: problemContents.randomElement()!)
            problems.append(chapter)
        }
        
        chapters[chapterId] = problems
        return problems
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
    private static let problemContents = [
        "What did you like best about this book?",
        "What did you like least about this book?",
        "What other books did this remind you of?",
        "Which characters in the book did you like best?",
        "Which characters did you like least?",
        "If you were making a movie of this book, who would you cast?",
        "Share a favorite quote from the book. Why did this quote stand out?",
        "What other books by this author have you read? How did they compare to this book?",
        "Would you read another book by this author? Why or why not?",
        "What feelings did this book evoke for you?",
        "What did you think of the book’s length? If it’s too long, what would you cut? If too short, what would you add?",
        "What songs does this book make you think of? Create a book group playlist together!",
    ]
    private static let problemImages = [
        "https://i.insider.com/5a4d32b37101ad53394d06c8?width=1000&format=jpeg&auto=webp",
        "https://miro.medium.com/max/529/1*hzUgileOMdOGoogm5W4zOg.png",
        "https://i.redd.it/mqpkgw2bwme21.png",
        "https://i.insider.com/51e5a888eab8ea044d000015?width=1136&format=jpeg",
        "https://static.wikia.nocookie.net/492737f9-9507-4247-8a30-c60f9264762a",
        "https://i2.wp.com/www.tuitionwithjason.sg/wp-content/uploads/2019/05/a-math-trigonometry-probably-the-most-challenging-question-for-mid-year-2019.png?fit=483%2C337&ssl=1",
        "http://1.bp.blogspot.com/-oN9Sv8bhkf4/TzOKk_pM7CI/AAAAAAAAAF8/gkHIJM_h9NI/s1600/2008_Tanjong_Katong_Girls_A_Maths_Page_01-q1-trigo-answer.jpg",
        "https://1.bp.blogspot.com/-o6oI31NruR8/YLtzbd8S5AI/AAAAAAAABxg/0HcHy6j5lsYj5FcIrK2TE6ClHy5AOAetACLcBGAsYHQ/s16000/Slide1.PNG",
        "http://4.bp.blogspot.com/-XVE6uTFPomw/TzKMId4SY5I/AAAAAAAAAFA/4vBPNFO_b3k/s1600/2008_Duman_High_A_Maths_Page_2-q4-trigo-with-solution.jpg",
        "https://www.telegraph.co.uk/content/dam/news/2016/05/15/Maths-problem-trending_trans_NvBQzQNjv4BqzTW4Ql1t-1Xt3_aTCx9yp4V4XZMU8yV22wInfrfUWRg.PNG?impolicy=logo-overlay",
        "https://d138zd1ktt9iqe.cloudfront.net/media/seo_landing_files/2-1606299629.png",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuAZIF7HnyXW0vsjT-Ah5q5w4mML2q_Ys91Ef96D8Y9-7mHAcLA29qSdgYlBCynilwGq0&usqp=CAU",
    ]
    private static let teacherNames = [
        "Liam",
        "Olivia",
        "Noah",
        "Lucas",
        "Isabella",
        "Benjamin",
        "James",
        "Sophia",
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
    static func getProblemContents() -> [String] {
        let problemCount = Int.random(in: 1 ... 3)
        var problems = [String]()
        for _ in 0 ..< problemCount {
            problems.append(problemContents.randomElement()!)
        }
        return problems
    }

}
