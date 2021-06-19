import XCTest
@testable import Marvel_App

// 03/02/2021 - have a look through this again

class MainViewControllerTests: XCTestCase {
    var subject: MainViewController!
    var fakeViewModel: FakeCharactersViewModel!

    override func setUp() {
        fakeViewModel = FakeCharactersViewModel()
        subject = MainViewController(viewModel: fakeViewModel)
    }

    override func tearDown() {
        super.tearDown()
        fakeViewModel = nil
        subject = nil
    }
    
    func testViewAppears() {
        subject.viewDidLoad()
        XCTAssertNotNil(subject.tableView)
        let delegate = subject.tableView.delegate
        let dataSource = subject.tableView.dataSource
        //03/02/2021 did not know what === is
        XCTAssertTrue(delegate === subject)
        XCTAssertTrue(dataSource === subject)
    }
    
    func testTableViewCellForRowAt() {
        let characters = MarvelCharacter.characterStub()
        subject.viewModel.listOfCharacters.append(characters)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterImageCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.nameLabel.text, characters.name)
    }
    
    func testTableViewDidSelectRowAt() {
        let characters = MarvelCharacter.characterStub()
        subject.viewModel.listOfCharacters.append(characters)
        subject.viewDidLoad()
        let cell: () = subject.tableView(subject.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
}
