import XCTest

@testable import Marvel_App

class MainViewCoordinatorTests: XCTestCase {
    var subject: MainViewCoordinator!
    var navigationController: UINavigationController!

    override func setUp() {
        navigationController = UINavigationController()
        subject = MainViewCoordinator(router: navigationController)
    }

    override func tearDown() {
        subject = nil
    }

    func testStart() {
        subject.start()
        let mainVC = navigationController.topViewController as? MainViewController
        XCTAssertNotNil(mainVC)
    }
    
    func testDidSelectCharacter() {
        let mockCharacter = MarvelCharacter(name: "name", description: "description", thumbnail: Thumbnail(path: "path", thumbnailExtension: .jpg), urls: [])
        subject.didSelect(character: mockCharacter)
        let characterDetailsVC = navigationController.topViewController as? CharacterDetailsViewController
        XCTAssertNotNil(characterDetailsVC)
    }
    
    
    func testDidSelectWithNoCharacter() {
        subject.didSelect(character: nil)
        let correctViewController = navigationController.topViewController as? CharacterDetailsViewController
        XCTAssertNil(correctViewController)
    }
}
