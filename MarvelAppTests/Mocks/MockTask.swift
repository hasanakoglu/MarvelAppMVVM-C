//
//  MockTask.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 20/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

@testable import Marvel_App

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?

    private let _error: Error?
    override var error: Error? {
        return _error
    }

    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!

    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self._error = error
    }

    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler(self.data, self.urlResponse, self.error)
        }
    }
}
