//
//  FavouritesManagerTests.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 30/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation
import XCTest

@testable import Marvel_App

class FavouritesManagerTests: XCTestCase {
    private var mockDefaults: MockDefaults!
    private var subject: FavouritesManager!
    
    override func setUp() {
        super.setUp()
        mockDefaults = MockDefaults()
        subject = FavouritesManager(userDefaults: mockDefaults)
    }
    
    override func tearDown() {
        mockDefaults = nil
        subject = nil
        super.tearDown()
    }
    
    func testAddToFavourites() throws {
        let character = MarvelCharacter.characterStub()
        subject.addToFavourites(for: [character])
        let favourites = try JSONDecoder().decode([MarvelCharacter].self, from: mockDefaults.setValue as! Data)
        XCTAssertEqual(favourites, [character])
    }
    
    func testRemoveFromFavourites() throws {
        let characters = [MarvelCharacter.characterStub()]
        let encodedCharacters = try JSONEncoder().encode(characters)
        mockDefaults.value = encodedCharacters
        
        let character = characters[0]
        subject.removeFromFavourites(character: character)
        let favourites = try JSONDecoder().decode([MarvelCharacter].self, from: mockDefaults.setValue as! Data)
        XCTAssertFalse(favourites.contains(character))
    }
    
    func testRetrieveFavourites() throws {
        let characters = [MarvelCharacter.characterStub()]
        let encodedCharacters = try JSONEncoder().encode(characters)
        mockDefaults.value = encodedCharacters
        
        let favourites = try JSONDecoder().decode([MarvelCharacter].self, from: mockDefaults.value as! Data)
        let savedFavourites = subject.retrieveFavourites()
        XCTAssertEqual(savedFavourites, favourites)
    }
    
    func testRetrieveFavouritesReturnsEmpty() {
        let savedFavourites = subject.retrieveFavourites()
        XCTAssertEqual(savedFavourites, [])
    }
}
