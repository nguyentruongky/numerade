//  Created by Ky Nguyen

import UIKit

class Dataset {
    private static var books = [String: BookDetail]()
    private static var chapters = [String: [Problem]]()
    private static var problems = [String: ProblemDetail]()

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

    static func getProblemDetail(book: Book, chapter: Chapter, problem: Problem) -> ProblemDetail {
        if let detail = problems[problem.id] {
            return detail
        }

        let choices = get4Choices()
        let newProblemsCount = Int.random(in: 0...5)
        var newProblems = [Problem]()
        for i in 2 ..< newProblemsCount {
            let prob = Problem(imageUrl: problemImages.randomElement()!,
                               order: i,
                               teacherImageUrl: "",
                               teacherName: teacherNames.randomElement()!,
                               content: problem.content)
            newProblems.append(prob)
        }
        let detail = ProblemDetail(book: book,
                                   chapter: chapter,
                                   problem: problem,
                                   videoUrl: videoUrls.randomElement()!,
                                   choices: choices,
                                   answer: choices.randomElement()!,
                                   topics: ["No topics available"],
                                   moreAnswers: newProblems,
                                   transcript: transcripts.randomElement()!)
        problems[problem.id] = detail
        return detail
    }

    static private let videoUrls = [
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"
    ]

    static private let transcripts = [
    "The pandemic spurred an unprecedented reclamation of urban space, ushering in a seemingly bygone era of pedestrian pastimes, as cars were sidelined in favor of citizens. Highlighting examples from across the United States, environmental designer Kevin J. Krizek reflects on how temporary shifts -- like transforming streets into places for dining, recreation and community -- can become permanent fixtures that make for more livable and sustainable cities.",
        "There's a creeping sameness in many of our newest urban buildings and streetscapes, says architect Vishaan Chakrabarti. And this physical homogeneity -- the result of regulations, mass production, safety issues and cost considerations, among other factors -- has blanketed our planet in a social and psychological homogeneity, too. In this visionary talk, Chakrabarti calls for a return to designing magnetic, lyrical cities that embody their local cultures and adapt to the needs of our changing world and climate.",
        "When asked to build housing for 100 families in Chile ten years ago, Alejandro Aravena looked to an unusual inspiration: the wisdom of favelas and slums. Rather than building a large building with small units, he built flexible half-homes that each family could expand on. It was a complex problem, but with a simple solution — one that he arrived at by working with the families themselves. With a chalkboard and beautiful images of his designs, Aravena walks us through three projects where clever rethinking led to beautiful design with great benefit.",
        "Venice is sinking. To save it, Rachel Armstrong says we need to outgrow architecture made of inert materials and, well, make architecture that grows itself. She proposes a not-quite-alive material that does its own repairs and sequesters carbon, too.",
        "The European languages are members of the same family. Their separate existence is a myth. For science, music, sport, etc, Europe uses the same vocabulary. The languages only differ in their grammar, their pronunciation and their most common words. Everyone realizes why a new common language would be desirable: one could refuse to pay expensive translators. To achieve this, it would be necessary to have uniform grammar, pronunciation and more common words. If several languages coalesce, the grammar of the resulting language is more simple and regular than that of the individual languages. The new common language will be more simple and regular than the existing European languages. It will be as simple as Occidental; in fact, it will be Occidental. To an English person, it will seem like simplified English, as a skeptical Cambridge friend of mine told me what Occidental is.The European languages are members of the same family. Their separate existence is a myth. For science, music, sport, etc, Europe uses the same vocabulary. The languages only differ in their grammar, their pronunciation and their most common words. Everyone realizes why a new common language would be desirable: one could refuse to pay expensive translators.",
        "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth. Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar. The Big Oxmox advised her not to do so, because there were thousands of bad Commas, wild Question Marks and devious Semikoli, but the Little Blind Text didn’t listen. She packed her seven versalia, put her initial into the belt and made herself on the way. When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrove, the headline of Alphabet Village and the subline of her own road, the Line Lane. Pityful a rethoric question ran over her cheek."
    ]
    private static func get4Choices() -> [String] {
        var myChoices = [String]()
        for _ in 0 ..< 4 {
            var selected = choices.randomElement()!
            while myChoices.contains(selected) {
                selected = choices.randomElement()!
            }
            myChoices.append(selected)
        }

        return myChoices
    }
    private static let choices = [
        "Create a simple video playback app with built-in controls.",
        "Audio Session",
        "User Interface",
        "Playback Behavior",
        "Jefferson Davis",
        "Salmon P. Chase, the Secretary of the Treasury during the Civil War",
        "West Virginia",
        "3.9 million",
        "Between 10 and 15 million.",
        "President Andrew Johnson in 1868",
        "France",
        "Hiram Rhodes Revels took his oath of office in 1870",
        "About 27.5 million",
        "John Adams",
        "Benjamin Franklin",
        "More than 230",
        "The Treaty of Paris",
        "A quarter-cask of wine",
        "August 2, 1776 (The final draft was completed July 4, but it wasn’t actually signed until nearly a month later).",
        "The Intolerable Acts (or the Coercive Acts in Great Britain).",
        "Sept. 3, 1783.",
        "The Powhatan tribal nation",
        "St. Augustine, Florida, founded in 1565 by Don Pedro Menendez de Aviles of Spain",
        "John Rolfe, a tobacco planter",
        "In 1607",
        "The Mayflower"
    ]

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
        "What songs does this book make you think of? Create a book group playlist together!"
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
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuAZIF7HnyXW0vsjT-Ah5q5w4mML2q_Ys91Ef96D8Y9-7mHAcLA29qSdgYlBCynilwGq0&usqp=CAU"
    ]
    private static let teacherNames = [
        "Liam",
        "Olivia",
        "Noah",
        "Lucas",
        "Isabella",
        "Benjamin",
        "James",
        "Sophia"
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
