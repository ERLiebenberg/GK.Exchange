//
//  MockServiceFactory.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

@testable import GK_Exchange

class MockServiceFactory: ServiceFactory {
    
    private let mockDataTask: MockDataTask
    
    var makeDataTaskCount = 0
    var makeServiceURLCount = 0
    var serializeJSONCount = 0
    
    var expectedURL: URL?
    var actualURL: URL?
    
    var expectedData: Data?
    var expectedResponse: Any?
    var expectedError: Error?
    
    var expectedQuery: String?
    var expectedServiceUrl: URL?

    var expectedItemsDictionary: JSONDictionary?
    
    init(mockDataTask: MockDataTask) {
        self.mockDataTask = mockDataTask
    }
    
    func verify() -> Bool {
        return makeDataTaskCount == 0 && makeDataTaskCount == 0 && mockDataTask.verify() && serializeJSONCount == 0
    }
    
    var dataTask: URLSessionDataTask? {
        return mockDataTask
    }
    
    var asynchronousRunner: AsynchronousRunner {
        return MockAsynchronousRunner()
    }
    
    func expectMakeDataTask(url: URL, expectedData data: Data?, expectedResponse response: Any?, expectedError error: Error?) {
        makeDataTaskCount -= 1
        expectedURL = url
        expectedData = data
        expectedResponse = response
        expectedError = error
    }
    
    func makeDataTask(url: URL, completion: @escaping (Data?, Any?, Error?) -> ()) {
        makeDataTaskCount += 1
        actualURL = url
        completion(expectedData, expectedResponse, expectedError)
    }
    
    func expectMakeServiceUrl(query: String, returnUrl url: URL?) {
        makeServiceURLCount -= 1
        expectedQuery = query
        expectedServiceUrl = url
    }
    
    func makeSearchUrl(query: String) -> URL? {
        makeServiceURLCount += 1
        return expectedServiceUrl
    }
    
    func expectSerializeJSON(itemsDictionary: JSONDictionary?) {
        serializeJSONCount -= 1
        expectedItemsDictionary = itemsDictionary
    }
    
    func serializeJSON(data: Data) throws -> JSONDictionary? {
        serializeJSONCount += 1
        return expectedItemsDictionary
    }
}

class MockDataTask: URLSessionDataTask {
    
    var cancelCount = 0
    var resumeCount = 0
    
    func verify() -> Bool {
        return cancelCount == 0 && resumeCount == 0
    }
    
    func expectCancel() {
        cancelCount -= 1
    }
    
    override func cancel() {
        cancelCount += 1
    }
    
    func expectResume() {
        resumeCount -= 1
    }
    
    override func resume() {
        resumeCount += 1
    }
}
