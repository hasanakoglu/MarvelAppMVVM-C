//
//  CharacterDetailsViewModelTests.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 01/07/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation
import XCTest

@testable import Marvel_App

class CharacterDetailsViewModelTests: XCTestCase {
    var subject: CharacterDetailsViewModel!
    var fakeFavouritesManager: FakeFavouritesManager!
    let character = MarvelCharacter.characterStub()

    override func setUp() {
        super.setUp()
        fakeFavouritesManager = FakeFavouritesManager()
        subject = CharacterDetailsViewModel(favouritesManager: fakeFavouritesManager)
    }

    override func tearDown() {
        subject = nil
    }
    
    func testViewWillAppear() {
        subject.viewWillAppear()
        XCTAssertTrue(fakeFavouritesManager.retrieveFavouritesCalled)
    }
    
    func testAddToFavourites() {
        subject.addToFavourites(character: character)
        XCTAssertTrue(fakeFavouritesManager.addToFavouritesCalled)
    }
    
    func testRemoveFromFavourites() {
        subject.removeFromFavourites(character: character)
        XCTAssertTrue(fakeFavouritesManager.removeFromFavouritesCalled)
    }
    
    func testButtonSelectedStateTrue() {
        subject.favourites.append(character)
        XCTAssertEqual(subject.buttonSelectedState(character: character), true)
    }
    
    func testButtonSelectedStateFalse() {
        XCTAssertEqual(subject.buttonSelectedState(character: character), false)
    }
}
