//
//  MockURLSession.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 20/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

@testable import Marvel_App

class MockURLSession: URLSession {
    private let mockTask: MockTask
    var cachedUrl: URL?

   init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: urlResponse, error:
            error)
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = url
        mockTask.completionHandler = completionHandler
        return mockTask
    }
}
