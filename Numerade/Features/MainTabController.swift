//  Created by Ky Nguyen

import UIKit

class MainTabController: UITabBarController {
    private(set) lazy var booksController = BooksController()
    private(set) lazy var askController = AskController()
    private(set) lazy var snapSolveController = UIViewController()
    private(set) lazy var bootCampsController = UIViewController()
    private(set) lazy var moreController = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        var controllers: [UIViewController] = []
        controllers.append(setupTabItem(for: booksController, title: "Books"))
        controllers.append(setupTabItem(for: askController, title: "Ask"))
        controllers.append(setupTabItem(for: snapSolveController, title: "SnapSolve"))
        controllers.append(setupTabItem(for: bootCampsController, title: "Bootcamps"))
        controllers.append(setupTabItem(for: moreController, title: "More"))
        
        viewControllers = controllers
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(hex: "#5037FB")
    }
    
    private func setupTabItem(for controller: UIViewController, title: String) -> UINavigationController {
        let icon = UIImage(named: title.lowercased())
        controller.tabBarItem = UITabBarItem(title: title, image: icon, selectedImage: icon)
        return UINavigationController(rootViewController: controller)
    }
}
