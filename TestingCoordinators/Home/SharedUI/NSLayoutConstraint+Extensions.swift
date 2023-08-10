import UIKit

public extension NSLayoutConstraint {
    static func activate(@GenericBuilder<NSLayoutConstraint> _ constraints: () -> [NSLayoutConstraint]) {
        activate(constraints())
    }
}
