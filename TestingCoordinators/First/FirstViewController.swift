import UIKit

class FirstViewController: UIViewController {
    init(viewModel: FirstViewModel) {
        super.init(nibName: nil, bundle: nil)
        title = "First"
        
        let content = UILabel.body(text: "This screen is handled by HomeCoordinator")
        let showYellowButton = UIButton.primary(text: "Continue", action: viewModel.continueTapped)
        view = BasicView(backgroundColor: .systemBackground, scrollingContent: [content], footerContent: [showYellowButton])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

