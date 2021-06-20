//
//  CharacterRequestTests.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 20/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation
import XCTest

@testable import Marvel_App

class CharacterRequestTests: XCTestCase {
    var subject: CharacterRequest!
    var mockURLSession: MockURLSession!
    var mockCharacterRequest: MockCharacterRequest!
    
    override func setUp() {
        mockCharacterRequest = MockCharacterRequest()
        mockURLSession = MockURLSession(data: CharacterRequestTests.mockData, urlResponse: nil, error: nil)
        subject = CharacterRequest(session: mockURLSession)
    }

    override func tearDown() {
        subject = nil
    }
    
    func testFetchCharactersSuccess() {
        var result: Result<[MarvelCharacter], CharacterError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchCharacters { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
   
        XCTAssertNotNil(result?.value)
        XCTAssertNil(result?.error)
    }
    

    func testFetchCharactersFailure() {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        subject = CharacterRequest(session: mockURLSession)
        var result: Result<[MarvelCharacter], CharacterError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchCharacters { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)

        XCTAssertNil(result?.value)
        XCTAssertNotNil(CharacterError.jsonError)
    }
}

extension CharacterRequestTests {
    static var mockData: Data {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "characters", ofType: "json")!
        return FileManager().contents(atPath: path)!
    }
}
