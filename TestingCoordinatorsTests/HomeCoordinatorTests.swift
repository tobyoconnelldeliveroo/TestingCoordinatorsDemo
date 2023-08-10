import XCTest
@testable import TestingCoordinators

class SpyNavigationController: UINavigationController {
    var spyPushViewController: ((_ viewController: UIViewController, _ animated: Bool) -> Void)!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        spyPushViewController(viewController, animated)
    }
}

final class TestingCoordinatorsTests: XCTestCase {
    var navigationController: SpyNavigationController!
    var coordinator: HomeCoordinator!
    
    override func setUp() {
        navigationController = .init()
        coordinator = .init(navigationController: navigationController)
    }
    
    override func tearDown() {
        navigationController = nil
        coordinator = nil
    }
    
    func testStart() {
        // Given
        var viewController: UIViewController!
        var animated: Bool!
        
        navigationController.spyPushViewController = { spiedViewController, spiedAnimated in
            viewController = spiedViewController
            animated = spiedAnimated
        }
        
        // When
        coordinator.start()
        
        // Then
        XCTAssert(viewController is FirstViewController)
        XCTAssertFalse(animated)
    }
}
