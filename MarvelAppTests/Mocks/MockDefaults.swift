//
//  MockDefaults.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 01/07/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

@testable import Marvel_App

class MockDefaults: UserDefaultsProtocol {
    var setValue: Any?
    var key = "test"
    func set(_ value: Any?, forKey defaultName: String) {
        setValue = value
        key = defaultName
    }
    
    var value: Any?
    func value(forKey defaultName: String) -> Any? {
        key = defaultName
        return value
    }
}
