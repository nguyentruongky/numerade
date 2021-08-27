//  Created by Ky Nguyen

import UIKit

class ProblemDetailUI {
    let videoView = VideoView()
    private let teacherImageView = UIImageView(imageName: "user", contentMode: .scaleAspectFill)
    private let teacherNameLabel = UILabel(font: .main(.bold, size: 15), color: .color_0D0D0D)
    let closeButton = UIButton(imageName: "down")
    private let likeButton = SocialButton(iconName: "like", title: "Like")
    private let shareButton = SocialButton(iconName: "share", title: "Share")
    private let saveButton = SocialButton(iconName: "save", title: "Save")
    private let reportButton = SocialButton(iconName: "report", title: "Report")
    private let buttonStack = UIStackView(axis: .horizontal, distribution: .fillEqually, alignment: .fill, space: 8)
    private let questionLabel = UILabel(font: .main(size: 15), color: .color_0D0D0D, numberOfLines: 0)
    private let answerStack = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, space: 4)
    private let answerLabel = UILabel(font: .main(size: 15), color: .color_0D0D0D, numberOfLines: 0)
    private let containerView = UIView()
    private let bottomView = ProblemBottomView()

    func setupView(_ view: UIView) {
        view.addSubviews(views: videoView)
        videoView.horizontalSuperview()
        videoView.topToSuperview()
        videoView.height(UIScreen.main.bounds.width * 9 / 16)
        
        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.contentEdgeInsets = UIEdgeInsets(space: 8)
        view.addSubviews(views: closeButton)
        closeButton.square(edge: 44)
        closeButton.topLeftToSuperView(topSpace: 8, leftSpace: 16)

        setupTeacherView(inView: containerView)
        setupSocialButton(inView: containerView)
        setupProblemView(inView: containerView)
        setupBottomView(inView: containerView)

        setupScrollView(inView: view)
    }
    
    func setDataToUI(_ data: ProblemDetail) {
        videoView.playVideo(url: data.videoUrl)
        
        teacherImageView.downloadImage(from: data.problem.teacherImageUrl)
        teacherNameLabel.text = data.problem.teacherName
        questionLabel.text = data.problem.content
        showAnswers(data.choices, correctAnswer: data.answer)

        bottomView.informationView.bookTitleLabel.text = data.book.title
        bottomView.informationView.chapterLabel.text = "Chapter \(data.chapter.order)"
        bottomView.informationView.chapterNameLabel.text = data.chapter.title
        bottomView.informationView.topicLabel.text = data.topics.joined()
        
        bottomView.moreAnswerView.datasource = data.moreAnswers
        bottomView.transcriptView.textLabel.text = data.transcript
    }

    private func showAnswers(_ answers: [String], correctAnswer: String) {
        answerStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let abcd = ["A", "B", "C", "D"]
        var orderedAnswer = [String]()
        for i in 0 ..< answers.count {
            orderedAnswer.append("\(abcd[i]). \(answers[i])")
            if answers[i] == correctAnswer {
                answerLabel.text = abcd[i]
            }
        }
        
        orderedAnswer.forEach {
            answerStack.addArrangeViews(views: UILabel(text: $0, font: .main(), color: .color_0D0D0D, numberOfLines: 0))
        }
    }

    private func setupTeacherView(inView view: UIView) {
        view.addSubviews(views: teacherImageView)
        teacherImageView.leftToSuperview(space: 16)
        teacherImageView.topToSuperview()
        teacherImageView.square(edge: 48)
        teacherImageView.setCorner(radius: 24)

        view.addSubviews(views: teacherNameLabel)
        teacherNameLabel.leftHorizontalSpacing(toView: teacherImageView, space: 16)
        teacherNameLabel.centerY(toView: teacherImageView)
    }

    private func setupSocialButton(inView view: UIView) {
        buttonStack.addArrangeViews(views: likeButton, shareButton, saveButton, reportButton)
        view.addSubviews(views: buttonStack)
        buttonStack.horizontalSuperview(space: 24)
        buttonStack.verticalSpacing(toView: teacherImageView, space: 16)

        let line = ViewFactory.createHorizontalLine(color: UIColor(hex: "#F9FAFF"), lineHeight: 10)
        view.addSubviews(views: line)
        line.horizontalSuperview()
        line.verticalSpacing(toView: buttonStack, space: 12)
    }

    private func setupProblemView(inView view: UIView) {
        let problemTitleLabel = UILabel(text: "Problem", font: .main(.bold, size: 15), color: .color_0D0D0D)
        view.addSubviews(views: problemTitleLabel)
        problemTitleLabel.left(toView: teacherImageView)
        problemTitleLabel.verticalSpacing(toView: buttonStack, space: 56)

        view.addSubviews(views: questionLabel)
        questionLabel.left(toView: teacherImageView)
        questionLabel.centerXToSuperview()
        questionLabel.verticalSpacing(toView: problemTitleLabel, space: 8)

        view.addSubviews(views: answerStack)
        answerStack.centerXToSuperview()
        answerStack.left(toView: questionLabel, space: 24)
        answerStack.verticalSpacing(toView: questionLabel, space: 8)

        let answerTitleLabel = UILabel(text: "Answer", font: .main(.bold, size: 15), color: .color_0D0D0D)
        view.addSubviews(views: answerTitleLabel)
        answerTitleLabel.left(toView: teacherImageView)
        answerTitleLabel.verticalSpacing(toView: answerStack, space: 48)

        view.addSubviews(views: answerLabel)
        answerLabel.left(toView: teacherImageView)
        answerLabel.verticalSpacing(toView: answerTitleLabel, space: 8)

        let line = ViewFactory.createHorizontalLine(color: UIColor(hex: "#F9FAFF"), lineHeight: 10)
        view.addSubviews(views: line)
        line.horizontalSuperview()
        line.verticalSpacing(toView: answerLabel, space: 36)
    }

    private func setupBottomView(inView view: UIView) {
        view.addSubviews(views: bottomView)
        bottomView.horizontalSuperview()
        bottomView.verticalSpacing(toView: answerLabel, space: 48)
        bottomView.bottomToSuperview()
    }

    private func setupScrollView(inView view: UIView) {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubviews(views: containerView)
        containerView.fillSuperView()
        containerView.width(toView: scrollView)

        view.addSubviews(views: scrollView)
        scrollView.horizontalSuperview()
        scrollView.verticalSpacing(toView: videoView, space: 16)
        scrollView.bottomToSuperview()
    }

    class SocialButton: UIButton {
        let iconImageView = UIImageView(contentMode: .scaleAspectFit)
        let textLabel = UILabel(font: .main(.bold, size: 14), color: UIColor(hex: "#707070"), alignment: .center)

        convenience init(iconName: String, title: String) {
            self.init(frame: .zero)
            setupView()
            iconImageView.image = UIImage(named: iconName)
            textLabel.text = title
        }

        func setupView() {
            addSubviews(views: iconImageView, textLabel)
            stackVertically(views: [iconImageView, textLabel], viewSpaces: 16, topSpace: 0, bottomSpace: 0)
            iconImageView.square(edge: 24)
            iconImageView.centerXToSuperview()
            textLabel.horizontalSuperview()

        }
    }
}
