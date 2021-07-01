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
    private var userDefaults: UserDefaults!
    private var subject: FavouritesManager!
    private let key = "Fav"
    
    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults.standard
        userDefaults.removePersistentDomain(forName: #file)
        subject = FavouritesManager()
    }
    
    override func tearDown() {
        userDefaults = nil
        subject = nil
        super.tearDown()
    }
    
    func testAddToFavourites() {
        let character = MarvelCharacter.characterStub()
        subject.addToFavourites(for: [character])
        
        let favourites = userDefaults.object(forKey: key)
        XCTAssertNotNil(favourites)
    }
    
    func testRemoveFromFavourites() throws {
        let character = MarvelCharacter.characterStub()
        let encodedCharacters = try JSONEncoder().encode([character])
        userDefaults.setValue(encodedCharacters, forKey: key)
        
        let favourites = userDefaults.object(forKey: key)
        subject.removeFromFavourites(character: character)
        XCTAssertNil(favourites)
    }
    
    func testRetrieveFavourites() throws {
        let character = MarvelCharacter.characterStub()
        let encodedCharacter = try JSONEncoder().encode(character)
        userDefaults.setValue(encodedCharacter, forKey: key)
        
        let favourites = subject.retrieveFavourites()
        XCTAssertNotNil(favourites)
        XCTAssertEqual(favourites.count, 1)
    }
}
