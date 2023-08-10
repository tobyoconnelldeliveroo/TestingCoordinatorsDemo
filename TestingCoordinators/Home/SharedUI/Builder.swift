import Foundation

@resultBuilder
public struct GenericBuilder<T> {

    public typealias Expression = T
    public typealias Component = [T]

    public static func buildExpression(_ expression: Expression) -> Component {
        [expression]
    }

    public static func buildExpression(_ expression: Component) -> Component {
        expression
    }

    public static func buildExpression(_ expression: Expression?) -> Component {
        expression.map { [$0] } ?? []
    }

    public static func buildBlock(_ children: Component...) -> Component {
        children.flatMap { $0 }
    }

    public static func buildBlock(_ component: Component) -> Component {
        component
    }

    public static func buildOptional(_ children: Component?) -> Component {
        children ?? []
    }

    public static func buildEither(first child: Component) -> Component {
        child
    }

    public static func buildEither(second child: Component) -> Component {
        child
    }

    public static func buildArray(_ components: [Component]) -> Component {
        components.flatMap { $0 }
    }
}
