import UIKit

class BasicView: UIView {
    enum Constant {
        static let margin: CGFloat = 20
    }
    
    convenience init(backgroundColor: UIColor, scrollingContent: UIView..., footerContent: UIView...) {
        self.init(backgroundColor: backgroundColor, scrollingContent: scrollingContent, footerContent: footerContent)
    }
    
    convenience init(backgroundColor: UIColor, scrollingContent: UIView...) {
        self.init(backgroundColor: backgroundColor, scrollingContent: scrollingContent)
    }
    
    init(backgroundColor: UIColor, scrollingContent: [UIView], footerContent: [UIView] = []) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setupViewHierarchy(scrollingContent: scrollingContent, footerContent: footerContent)
    }
    
    private static func makeStackView(content: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: content)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = Constant.margin
        return stackView
    }
    
    private static func makeFooterStackView(content: [UIView]) -> UIStackView? {
        guard !content.isEmpty else { return nil }
        return makeStackView(content: content)
    }
    
    private func setupViewHierarchy(scrollingContent: [UIView], footerContent: [UIView]) {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollingStackView = Self.makeStackView(content: scrollingContent)
        let footerStackView = Self.makeFooterStackView(content: footerContent)
        
        scrollView.addSubview(scrollingStackView)
        addSubview(scrollView)
        footerStackView.map(addSubview)
                
        NSLayoutConstraint.activate {
            scrollingStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: Constant.margin)
            scrollingStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
            scrollingStackView.leadingAnchor.constraint(equalTo: scrollView.readableContentGuide.leadingAnchor)
            scrollingStackView.trailingAnchor.constraint(equalTo: scrollView.readableContentGuide.trailingAnchor)
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
            
            if let footerStackView = footerStackView {
                scrollView.bottomAnchor.constraint(equalTo: footerStackView.topAnchor, constant: -Constant.margin)
                footerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).priority(.defaultHigh)
                footerStackView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -Constant.margin)
                footerStackView.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor)
                footerStackView.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor)
            } else {
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NSLayoutConstraint {
    @discardableResult
    func priority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
