//
//  Defaults.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 01/07/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func value(forKey defaultName: String) -> Any?
}

extension UserDefaults: UserDefaultsProtocol {}
