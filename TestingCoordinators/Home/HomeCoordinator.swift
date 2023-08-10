import UIKit

class HomeCoordinator {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FirstViewModel(continueTapped: goToSecond)
        let viewController = FirstViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    
    private func goToSecond() {
        let viewModel = SecondViewModel(
            doneTapped: {
                self.navigationController?.popViewController(animated: true)
            }
        )
        let viewController = SecondViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
