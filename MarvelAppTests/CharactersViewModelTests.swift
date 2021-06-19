import XCTest
@testable import Marvel_App

// 03/02/2021 check all this again
class CharactersViewModelTests: XCTestCase {
    var subject: CharactersViewModel!
    var fakeCharacterViewModel: FakeCharactersViewModel!
    var mockURLSession: MockURLSession!
    var mockCharacterRequest: MockCharacterRequest!

    override func setUpWithError() throws {
        fakeCharacterViewModel = FakeCharactersViewModel()
        mockCharacterRequest = MockCharacterRequest()
        mockURLSession = MockURLSession(data: fakeCharacterViewModel.testImage?.pngData(), urlResponse: nil, error: nil)
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
    
    func testGetImage() {
        subject.listOfCharacters = fakeCharacterViewModel.listOfCharacters
        let promise = expectation(description: "get image success")
        subject.getImage(index: 0) { _ in
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(subject.characterImages.count, 1)
    }
}

// 03/02/2021 - so important to remember this
extension MarvelCharacter {
    static func characterStub() -> MarvelCharacter {
        return MarvelCharacter(name: "name", description: "desc", thumbnail: Thumbnail(path: "test", thumbnailExtension: .jpg), urls: [MarvelURL(type: .detail, url: "")])
    }
}

// 03/02/2021 - check this
class MockCharacterRequest: CharacterRequestProtocol {
    var fetchCharactersCalled: Bool = false
    func fetchCharacters(completion: @escaping (Result<[MarvelCharacter], CharacterError>) -> ()) {
        if fetchCharactersCalled == true {
            completion(.success([MarvelCharacter.characterStub()]))
        } else  {
            completion(.failure(CharacterError.noData))
        }
        return
    }
}

class FakeCharactersViewModel: CharactersViewModelProtocol {
    var listOfCharacters: [MarvelCharacter] = [MarvelCharacter.characterStub()]
    
    var characterImages: [String : UIImage] = [:]
    
    var fetchCharactersCalled: Bool = false
    func fetchCharacters(completion: @escaping () -> ()) {
        fetchCharactersCalled = true
        return
    }
    
    var getImageCalled = true
    var testImage = UIImage(named: "test")
    func getImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if getImageCalled == true {
            completion(testImage)
        } else {
            completion(nil)
        }
    }

}

class MockURLSession: URLSession {
    private let mockTask: MockTask
    var cachedUrl: URL?

   init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: urlResponse, error:
            error)
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = url
        mockTask.completionHandler = completionHandler
        return mockTask
    }
}

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?

    private let _error: Error?
    override var error: Error? {
        return _error
    }

    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!

    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self._error = error
    }

    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler(self.data, self.urlResponse, self.error)
        }
    }
}
