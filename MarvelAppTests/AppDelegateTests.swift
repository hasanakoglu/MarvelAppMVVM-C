//
//  AppDelegateTests.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 20/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import XCTest

@testable import Marvel_App

class AppDelegateTests: XCTestCase {
    var subject: AppDelegate!
    
    override func setUp() {
        subject = AppDelegate()
        _ = subject.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }

    override func tearDown() {
        subject = nil
    }

    func testAppDelegateLaunch_CreatesWindow() {
        XCTAssertNotNil(subject.window)
    }
    
    func testAppDelegateLaunch_SetsUpRootViewControllerCorrectly() {
        guard let rootViewController = subject.window?.rootViewController else {
            XCTFail("rootViewController is nil")
            return
        }
        
        let mainVC = rootViewController as? MainTabBarController
        XCTAssertNotNil(mainVC)
    }
}
