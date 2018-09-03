//
//  QuestionServiceImplementationTests.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import XCTest

@testable import GK_Exchange

class QuestionsServiceImplementationTests: XCTestCase {
    
    var mockServiceFactory: MockServiceFactory!
    var mockDataTask = MockDataTask()
    
    var serviceUnderTest: QuestionsServiceImplementation!
    
    override func setUp() {
        super.setUp()
        
        mockServiceFactory = MockServiceFactory(mockDataTask: mockDataTask)
        serviceUnderTest = QuestionsServiceImplementation(factory: mockServiceFactory)
    }
    
    override func tearDown() {
        XCTAssertTrue(mockServiceFactory.verify())
        XCTAssertTrue(mockDataTask.verify())
        
        super.tearDown()
    }
    
    func testGetQuestionItemsShouldNotRetrieveQuestionItemsFromServiceWhenUrlIsNil() {
        let request = QuestionRequestModel(searchTerm: "nil")
        
        mockServiceFactory.expectMakeServiceUrl(query: generateQuery(searchTerm: request.searchTerm), returnUrl: nil)
        serviceUnderTest.getQuestionItems(questionRequest: request) { (responseItems, error) in
            XCTAssertNil(responseItems)
            XCTAssertEqual(ServiceError.noUrl, error)
        }
    }
    
    func testGetQuestionItemsFailureShouldCompleteWithErrorWhenServiceReturnsNoResponse() {
        let request = QuestionRequestModel(searchTerm: "search")
        let url = generateUrl(searchTerm: "search")
        
        mockDataTask.expectCancel()
        mockServiceFactory.expectMakeServiceUrl(query: generateQuery(searchTerm: request.searchTerm), returnUrl:url)
        mockServiceFactory.expectMakeDataTask(url: url, expectedData: Data(), expectedResponse: nil, expectedError: ServiceError.noResponseData)
        
        serviceUnderTest.getQuestionItems(questionRequest: request) { (responseItems, error) in
            XCTAssertNil(responseItems)
            XCTAssertEqual(ServiceError.noResponseData, error)
        }
        
        mockDataTask.expectResume()
        
        XCTAssertEqual(mockServiceFactory.expectedURL, mockServiceFactory.actualURL)
    }
    
    func testGetQuestionItemsFailureShouldCompleteWithErrorWhenServiceReturnsNoData() {
        let request = QuestionRequestModel(searchTerm: "search")
        let url = generateUrl(searchTerm: "search")
        
        mockDataTask.expectCancel()
        mockServiceFactory.expectMakeServiceUrl(query: generateQuery(searchTerm: request.searchTerm), returnUrl:url)
        mockServiceFactory.expectMakeDataTask(url: url, expectedData: nil, expectedResponse: ["":""], expectedError: ServiceError.noResponseData)
        
        serviceUnderTest.getQuestionItems(questionRequest: request) { (responseItems, error) in
            XCTAssertNil(responseItems)
            XCTAssertEqual(ServiceError.noResponseData, error)
        }
        
        mockDataTask.expectResume()
        
        XCTAssertEqual(mockServiceFactory.expectedURL, mockServiceFactory.actualURL)
    }
    
    func testGetQuestionItemsFailureShouldCompleteWithErrorWhenServiceReturnsInvalidDataAndJsonSerializationFails() {
        let request = QuestionRequestModel(searchTerm: "search")
        let url = generateUrl(searchTerm: "search")
        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        mockDataTask.expectCancel()
        mockServiceFactory.expectMakeServiceUrl(query: generateQuery(searchTerm: request.searchTerm), returnUrl:url)
        mockServiceFactory.expectMakeDataTask(url: url, expectedData: Data(), expectedResponse: httpResponse, expectedError: nil)
        mockServiceFactory.expectSerializeJSON(itemsDictionary: nil)
        
        serviceUnderTest.getQuestionItems(questionRequest: request) { (responseItems, error) in
            XCTAssertNil(responseItems)
            XCTAssertEqual(ServiceError.parseError, error)
        }
        
        mockDataTask.expectResume()
        
        XCTAssertEqual(mockServiceFactory.expectedURL, mockServiceFactory.actualURL)
    }
    
    func testGetQuestionItemsFailureShouldCompleteWithErrorWhenItemsKeyisNotFoundInResponse() {
        let request = QuestionRequestModel(searchTerm: "search")
        let url = generateUrl(searchTerm: "search")
        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedItemsDictionary = ["items": [TestDataGenerator.generateQuestionItemDictionary()]]
    
        mockDataTask.expectCancel()
        mockServiceFactory.expectMakeServiceUrl(query: generateQuery(searchTerm: request.searchTerm), returnUrl:url)
        mockServiceFactory.expectMakeDataTask(url: url, expectedData: Data(), expectedResponse: httpResponse, expectedError: nil)
        mockServiceFactory.expectSerializeJSON(itemsDictionary: expectedItemsDictionary)
        
        serviceUnderTest.getQuestionItems(questionRequest: request) { (responseItems, error) in
            XCTAssertNotNil(responseItems)
            XCTAssertNil(error)
        }
        
        mockDataTask.expectResume()
        
        XCTAssertEqual(mockServiceFactory.expectedURL, mockServiceFactory.actualURL)
    }
    
    func testGetImageUrlFailureShouldReturnErrorWhenServiceReturnsNoData() {
        let url = URL(string: "url")!
        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        mockDataTask.expectCancel()
        mockServiceFactory.expectMakeDataTask(url: url, expectedData: nil, expectedResponse: httpResponse, expectedError: nil)
        
        serviceUnderTest.getImageFrom(url: url) { (imageData, error) in
            XCTAssertNil(imageData)
            XCTAssertEqual(ServiceError.noResponseData, error)
        }
        
        mockDataTask.expectResume()
        
        XCTAssertEqual(mockServiceFactory.expectedURL, mockServiceFactory.actualURL)
    }
    
    func testGetImageUrlFailureShouldReturnErrorWhenServiceReturnsErrorStatusCode() {
        let url = URL(string: "url")!
        let httpResponse = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
        
        mockDataTask.expectCancel()
        mockServiceFactory.expectMakeDataTask(url: url, expectedData: Data(), expectedResponse: httpResponse, expectedError: nil)
        
        serviceUnderTest.getImageFrom(url: url) { (imageData, error) in
            XCTAssertNil(imageData)
            XCTAssertEqual(ServiceError.noResponseData, error)
        }
        
        mockDataTask.expectResume()
        
        XCTAssertEqual(mockServiceFactory.expectedURL, mockServiceFactory.actualURL)
    }
    
    func testGetImageUrlSuccessShouldCompleteWithImageData() {
        let url = URL(string: "url")!
        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
    
        let expected = Data()
    
        mockDataTask.expectCancel()
        mockServiceFactory.expectMakeDataTask(url: url, expectedData: expected, expectedResponse: httpResponse, expectedError: nil)
        
        serviceUnderTest.getImageFrom(url: url) { (imageData, error) in
            XCTAssertEqual(expected, imageData)
            XCTAssertNil(error)
        }
        
        mockDataTask.expectResume()
        
        XCTAssertEqual(mockServiceFactory.expectedURL, mockServiceFactory.actualURL)
    }
}

extension QuestionsServiceImplementationTests {
    
    func generateQuery(searchTerm: String) -> String {
        return "pagesize=20&order=desc&sort=activity&tagged=\(searchTerm)&site=stackoverflow&filter=withbody"
    }
    
    func generateUrl(searchTerm: String) -> URL {
        var urlComponents = URLComponents(string: "https://api.stackexchange.com/2.2/questions")!
        urlComponents.query = "pagesize=20&order=desc&sort=activity&tagged=\(searchTerm)&site=stackoverflow&filter=withbody"
        
        return urlComponents.url!
    }
}
