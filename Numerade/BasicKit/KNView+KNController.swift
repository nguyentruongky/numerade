//  Created by Ky Nguyen

import UIKit

class KNView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        xibSetup()
    }

    func setupView() { }
}

extension UIView {
    func xibSetup() {
        backgroundColor = UIColor.clear
        guard let view = loadNib() else { return }
        view.frame = bounds
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
    }

    func loadNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

class KNController: UIViewController {
    var shouldGetDataViewDidLoad: Bool {
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        if shouldGetDataViewDidLoad {
            getData()
        }
    }

    func setupView() {}
    func getData() {}
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }

    func showErrorMessage(_ message: String) {
        let vc = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(vc, animated: true)
    }

    @objc func popBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIView {
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }

    func zoomIn(_ isIn: Bool, complete: (() -> Void)? = nil) {
        let initialValue: CGFloat = isIn ? 0.8 : 1
        let endValue: CGFloat = isIn ? 1 : 0.8
        transform = transform.scaledBy(x: initialValue, y: initialValue)
        UIView.animate(withDuration: 0.35, delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.3,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.identity.scaledBy(x: endValue, y: endValue)
                       }, completion: { _ in complete?() })
    }
}
