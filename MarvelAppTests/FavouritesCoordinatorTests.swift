//
//  FavouritesCoordinatorTests.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 28/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import XCTest

@testable import Marvel_App

class FavouritesCoordinatorTests: XCTestCase {
    var subject: FavouritesCoordinator!
    var navigationController: UINavigationController!

    override func setUp() {
        navigationController = UINavigationController()
        subject = FavouritesCoordinator(router: navigationController)
    }

    override func tearDown() {
        subject = nil
    }

    func testStart() {
        subject.start()
        let mainVC = navigationController.topViewController as? FavouritesViewController
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

