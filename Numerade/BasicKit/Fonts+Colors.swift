//  Created by Ky Nguyen

import UIKit

extension UIFont {
    enum KNWeight: String {
        case black = "Muli-Black"
        case bold = "Muli-Bold"
        case medium = "Muli-SemiBold"
        case regular = "Muli-Regular"
    }
    
    static func main(_ weight: KNWeight = .regular, size: CGFloat = 15) -> UIFont {
        return font(weight.rawValue, size: size)
    }
    
    static func font(_ name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            if name.lowercased().contains("regular") {
                return UIFont.systemFont(ofSize: size)
            } else {
                return UIFont.boldSystemFont(ofSize: size)
            }
        }
        return font
    }
}

extension UIColor {
    static let color_201F24 = UIColor(hex: "#201F24")!
    static let color_424244 = UIColor(hex: "#424244")!
    static let color_86878B = UIColor(hex: "#86878B")!
    static let bg = UIColor(hex: "#292A2E")
    
}
