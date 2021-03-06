//
//  MainTabBarControllerTests.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 26/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation
import XCTest

@testable import Marvel_App

final class AppTabBarControllerTests: XCTestCase {
    var mockCoordinatorFactory: MockCoordinatorFactory!
    var subject: MainTabBarController!
    
    override func setUp() {
        super.setUp()
        mockCoordinatorFactory = MockCoordinatorFactory()
        subject = MainTabBarController(coordinatorFactory: mockCoordinatorFactory)
    }
    
    override func tearDown() {
        mockCoordinatorFactory = nil
        subject = nil
        super.tearDown()
    }
    
    func testMainViewCoordinator() {
        let mainViewCoordinator = subject.coordinators.compactMap { $0 as? MockListCoordinator }.first
        XCTAssertNotNil(mainViewCoordinator)
        XCTAssertTrue(mainViewCoordinator?.startCalled == true)
        XCTAssertTrue(subject.viewControllers?.first === mockCoordinatorFactory.listRouter)
    }
    
    func testFavouritesCoordinator() {
        let favouriteCoordinator = subject.coordinators.compactMap { $0 as? MockFavouriteCoordinator }.first
        XCTAssertNotNil(favouriteCoordinator)
        XCTAssertTrue(favouriteCoordinator?.startCalled == true)
        XCTAssertTrue(subject.viewControllers?.last === mockCoordinatorFactory.favouriteRouter)
    }
}

final class MockCoordinatorFactory: CoordinatorFactoryProtocol {
    var listRouter: Router?
    func makeMainViewCoordinator(router: Router) -> Coordinator {
        listRouter = router
        return MockListCoordinator()
    }
    
    var favouriteRouter: Router?
    func makeFavouritesCoordinator(router: Router) -> Coordinator {
        favouriteRouter = router
        return MockFavouriteCoordinator()
    }
}

class MockCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var startCalled: Bool = false
    func start() {
        startCalled = true
    }
    
    var didSelectCalled: Bool = false
    func didSelect(character: MarvelCharacter?) {
        didSelectCalled = true
    }
}

final class MockListCoordinator: MockCoordinator { }
final class MockFavouriteCoordinator: MockCoordinator { }
