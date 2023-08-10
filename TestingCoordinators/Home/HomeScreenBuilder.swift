import UIKit

protocol HomeScreenBuilding {
    func buildFirstScreen(viewModel: FirstViewModel) -> UIViewController
    func buildSecondScreen(viewModel: SecondViewModel) -> UIViewController
}

struct HomeScreenBuilder: HomeScreenBuilding {
    func buildFirstScreen(viewModel: FirstViewModel) -> UIViewController {
        FirstViewController(viewModel: viewModel)
    }
    
    func buildSecondScreen(viewModel: SecondViewModel) -> UIViewController {
        SecondViewController(viewModel: viewModel)
    }
}
