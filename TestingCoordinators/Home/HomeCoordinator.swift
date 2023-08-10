import UIKit

class HomeCoordinator {
    private weak var navigationController: UINavigationController?
    private let screenBuilder: HomeScreenBuilding
    
    init(
        navigationController: UINavigationController?,
        screenBuilder: HomeScreenBuilding = HomeScreenBuilder()
    ) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
    }
    
    func start() {
        let viewModel = FirstViewModel(continueTapped: goToSecond)
        let viewController = screenBuilder.buildFirstScreen(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    
    private func goToSecond() {
        let viewModel = SecondViewModel(
            doneTapped: {
                self.navigationController?.popViewController(animated: true)
            }
        )
        let viewController = screenBuilder.buildSecondScreen(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
