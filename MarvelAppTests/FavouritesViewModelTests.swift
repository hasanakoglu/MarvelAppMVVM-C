//
//  FavouritesViewModelTests.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 01/07/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation
import XCTest

@testable import Marvel_App

class FavouritesViewModelTests: XCTestCase {
    var subject: FavouritesViewModel!
    var fakeFavouritesManager: FakeFavouritesManager!
    let character = MarvelCharacter.characterStub()

    override func setUp() {
        super.setUp()
        fakeFavouritesManager = FakeFavouritesManager()
        subject = FavouritesViewModel(favouritesManager: fakeFavouritesManager)
    }

    override func tearDown() {
        subject = nil
    }
    
    func testViewWillAppear() {
        subject.viewWillAppear()
        XCTAssertTrue(fakeFavouritesManager.retrieveFavouritesCalled)
    }
}
