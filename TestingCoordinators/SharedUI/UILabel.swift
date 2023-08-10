import UIKit

extension UILabel {
    static func body(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = .zero
        label.adjustsFontForContentSizeCategory = true
        return label
    }
}
