import XCTest
@testable import TestingCoordinators

class SpyNavigationController: UINavigationController {
    var spyPushViewController: ((_ viewController: UIViewController, _ animated: Bool) -> Void)!
    var spyPopViewController: ((_ animated: Bool) -> UIViewController?)!

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        spyPushViewController(viewController, animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        spyPopViewController(animated)
    }
}

class MockHomeScreenBuilder: HomeScreenBuilding {
    var mockBuildFirstScreen: ((FirstViewModel) -> UIViewController)!
    var mockBuildSecondScreen: ((SecondViewModel) -> UIViewController)!

    func buildFirstScreen(viewModel: FirstViewModel) -> UIViewController {
        mockBuildFirstScreen(viewModel)
    }
    
    func buildSecondScreen(viewModel: SecondViewModel) -> UIViewController {
        mockBuildSecondScreen(viewModel)
    }
}

final class TestingCoordinatorsTests: XCTestCase {
    var navigationController: SpyNavigationController!
    var screenBuilder: MockHomeScreenBuilder!
    var coordinator: HomeCoordinator!
    
    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        coordinator = .init(navigationController: navigationController, screenBuilder: screenBuilder)
    }
    
    override func tearDown() {
        navigationController = nil
        coordinator = nil
    }
    
    func testStart() {
        // Given
        let mockFirstScreen = UIViewController()
        var viewController: UIViewController!
        var animated: Bool!
        
        navigationController.spyPushViewController = { spiedViewController, spiedAnimated in
            viewController = spiedViewController
            animated = spiedAnimated
        }
        
        screenBuilder.mockBuildFirstScreen = { _ in
            mockFirstScreen
        }
        
        // When
        coordinator.start()
        
        // Then
        XCTAssertEqual(viewController, mockFirstScreen)
        XCTAssertFalse(animated)
    }
    
    func testGoToSecond() {
        // Given
        let mockSecondScreen = UIViewController()
        var firstViewModel: FirstViewModel!
        var viewController: UIViewController!
        var animated: Bool!
        
        navigationController.spyPushViewController = { spiedViewController, spiedAnimated in
            viewController = spiedViewController
            animated = spiedAnimated
        }
        
        screenBuilder.mockBuildFirstScreen = { mockViewModel in
            firstViewModel = mockViewModel
            return UIViewController()
        }
        
        screenBuilder.mockBuildSecondScreen = { _ in
            mockSecondScreen
        }
        
        // When
        coordinator.start()
        firstViewModel.continueTapped()
        
        // Then
        XCTAssertEqual(viewController, mockSecondScreen)
        XCTAssertTrue(animated)
    }
    
    func testGoBackToFirst() {
        // Given
        var firstViewModel: FirstViewModel!
        var secondViewModel: SecondViewModel!
        var animated: Bool!
        
        navigationController.spyPushViewController = { _, _ in }
        
        navigationController.spyPopViewController = { spiedAnimated in
            animated = spiedAnimated
            return UIViewController()
        }
        
        screenBuilder.mockBuildFirstScreen = { mockViewModel in
            firstViewModel = mockViewModel
            return UIViewController()
        }
        
        screenBuilder.mockBuildSecondScreen = { mockViewModel in
            secondViewModel = mockViewModel
            return UIViewController()
        }
        
        // When
        coordinator.start()
        firstViewModel.continueTapped()
        secondViewModel.doneTapped()
        
        // Then
        XCTAssertTrue(animated)
    }
}
