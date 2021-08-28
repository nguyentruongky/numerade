//  Created by Ky Nguyen

import UIKit

extension ProblemDetailUI {
    class ProblemBottomView: KNView {
        private let tabBar = TabBar()
        let informationView = InformationView()
        let moreAnswerView = MoreAnswerView()
        let transcriptView = TranscriptView()
        private let tabViewContainer = UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, space: 0)

        override func setupView() {
            tabBar.didSelectTab = { [weak self] index in
                self?.didSelectTab(index: index)
            }
            setupTabBar()
            tabViewContainer.addArrangeViews(views: informationView)
            setupTabContainerView()
        }
        
        private func setupTabBar() {
            addSubviews(views: tabBar)
            tabBar.horizontalSuperview()
            tabBar.topToSuperview()
            tabBar.height(44)
        }
        
        private func setupTabContainerView() {
            addSubviews(views: tabViewContainer)
            tabViewContainer.horizontalSuperview()
            tabViewContainer.verticalSpacing(toView: tabBar)
            tabViewContainer.bottomToSuperview()
        }

        func didSelectTab(index: Int) {
            let tabs = [informationView, moreAnswerView, transcriptView]
            tabs.forEach {
                $0.removeFromSuperview()
            }

            tabViewContainer.addArrangeViews(views: tabs[index])
            layoutIfNeeded()
        }
    }
}

extension ProblemDetailUI {
    class TabBar: KNView {
        private lazy var informationButton = createTabButton(title: "Information")
        private lazy var moreAnswersButton = createTabButton(title: "More Answers")
        private lazy var transcriptButton = createTabButton(title: "Transcript")
        private let indicatorView = ViewFactory.createHorizontalLine(color: .black, lineHeight: 2)
        var didSelectTab: ((Int) -> Void)?

        override func setupView() {
            addSubviews(views: informationButton, moreAnswersButton, transcriptButton)
            stackHorizontally(views: [informationButton, moreAnswersButton, transcriptButton],
                              viewSpaces: 16, leftSpace: 16, rightSpace: nil)
            informationButton.verticalSuperview()
            moreAnswersButton.verticalSuperview()
            transcriptButton.verticalSuperview()

            let line = ViewFactory.createHorizontalLine(color: UIColor(hex: "#DBDBDB"))
            addSubviews(views: line)
            line.horizontalSuperview()
            line.bottomToSuperview()

            addSubviews(views: indicatorView)
            indicatorView.horizontal(toView: informationButton)
            indicatorView.bottomToSuperview()

            informationButton.addTarget(self, action: #selector(tappedInformation))
            moreAnswersButton.addTarget(self, action: #selector(tappedMoreAnswers))
            transcriptButton.addTarget(self, action: #selector(tappedTranscript))
        }

        @objc func tappedInformation() {
            setupIndicatorView(at: informationButton)
            didSelectTab?(0)
        }

        @objc func tappedMoreAnswers() {
            setupIndicatorView(at: moreAnswersButton)
            didSelectTab?(1)
        }

        @objc func tappedTranscript() {
            setupIndicatorView(at: transcriptButton)
            didSelectTab?(2)
        }

        private func setupIndicatorView(at view: UIView) {
            indicatorView.removeFromSuperview()
            view.addSubviews(views: indicatorView)
            indicatorView.horizontalSuperview()
            indicatorView.bottomToSuperview()
        }

        private func createTabButton(title: String) -> UIButton {
            return UIButton(title: title, titleColor: .color_0D0D0D, font: .main())
        }
    }
}
