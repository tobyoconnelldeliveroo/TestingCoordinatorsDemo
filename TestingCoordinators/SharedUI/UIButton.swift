import UIKit

extension UIButton {
    static func primary(text: String, action: (() -> Void)? = nil) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.title = text
        configuration.baseForegroundColor = .label
        configuration.baseForegroundColor = .secondarySystemBackground

        let button = UIButton(configuration: configuration, primaryAction: .init { _ in action?() })
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        return button
    }
}
