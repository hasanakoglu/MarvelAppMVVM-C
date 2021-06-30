import XCTest
@testable import Marvel_App

class CharactersViewModelTests: XCTestCase {
    var subject: CharactersViewModel!
    var fakeCharacterViewModel: FakeCharactersViewModel!
    var mockURLSession: MockURLSession!
    var mockCharacterRequest: MockCharacterRequest!

    override func setUpWithError() throws {
        fakeCharacterViewModel = FakeCharactersViewModel()
        mockCharacterRequest = MockCharacterRequest()
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        subject = CharactersViewModel(urlSession: mockURLSession, request: mockCharacterRequest)
    }

    override func tearDownWithError() throws {
        subject = nil
    }
    
    func testFetchCharacters() {
        mockCharacterRequest.fetchCharactersCalled = true
        subject.fetchCharacters {
        }
        XCTAssertEqual(subject.listOfCharacters.count, 1)
    }
}

extension MarvelCharacter {
    static func characterStub() -> MarvelCharacter {
        return MarvelCharacter(name: "name", description: "desc", thumbnail: Thumbnail(path: "test", thumbnailExtension: .jpg), urls: [MarvelURL(type: .detail, url: "www.google.com")])
    }
}
