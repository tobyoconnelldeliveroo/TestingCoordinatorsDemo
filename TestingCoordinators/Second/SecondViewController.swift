import UIKit

class SecondViewController: UIViewController {
    init(viewModel: SecondViewModel) {
        super.init(nibName: nil, bundle: nil)
        title = "Second"
        
        let content = UILabel.body(text: "This screen is handled by HomeCoordinator")
        let showYellowButton = UIButton.primary(text: "Done", action: viewModel.doneTapped)
        view = BasicView(backgroundColor: .systemBackground, scrollingContent: [content], footerContent: [showYellowButton])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

