//
//  QuestionViewModelTests.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import XCTest

@testable import GK_Exchange

class QuestionViewModelTests: XCTestCase {
    
    var mockView = MockQuestionView()
    var mockRepository = MockSearchRepository()
    
    var serviceUnderTest: QuestionViewModel!
    
    let expected = TestDataGenerator.generateQuestionModel()
    
    override func setUp() {
        super.setUp()
        
        serviceUnderTest = QuestionViewModel(view: mockView, questionModel: expected, repository: mockRepository)
    }
    
    override func tearDown() {
        XCTAssertTrue(mockView.verify())
        XCTAssertTrue(mockRepository.verify())
        
        super.tearDown()
    }
    
    func testConfigureViewShouldNotConfigureViewIfQuestionModelIsNil() {
        serviceUnderTest = QuestionViewModel(view: mockView, questionModel: nil, repository: mockRepository)
        
        serviceUnderTest.configureView()
    }
    
    func testConfigureViewShouldNotGetProfileImageIfOwnerProfileUrlIsNIl() {
        expected.ownerImageUrl = nil
        
        mockView.expectSetOwnerName(expected.ownerName)
        mockView.expectSetOwnerReputation(String(expected.ownerReputation!))
        mockView.expectSetQuestionDate("asked 1st January 1970 at 02:08")
        mockView.expectSetQuestionTitle(expected.title)
        mockView.expectSetQuestionBody(htmlString: expected.questionBody!)
        mockView.expectSetTags(expected.tags.joined(separator: ", "))
        
        serviceUnderTest.configureView()
        
        XCTAssertEqual(mockView.expectedOwnerName, mockView.actualOwnerName)
        XCTAssertEqual(mockView.expectedOwnerReputation, mockView.actualOwnerReputation)
        XCTAssertEqual(mockView.expectedQuestionDate, mockView.actualQuestionDate)
        XCTAssertEqual(mockView.expectedQuestionTitle, mockView.actualQuestionTitle)
        XCTAssertEqual(mockView.expectedQuestionBody, mockView.actualQuestionBody)
        XCTAssertEqual(mockView.expectedTags, mockView.actualTags)
    }
    
    func testConfigureViewShouldGetProfileImageFailureShouldNotSetOwnerProfileImage() {
        mockView.expectSetOwnerName(expected.ownerName)
        mockView.expectSetOwnerReputation(String(expected.ownerReputation!))
        mockView.expectSetQuestionDate("asked 1st January 1970 at 02:08")
        mockView.expectSetQuestionTitle(expected.title)
        mockView.expectSetQuestionBody(htmlString: expected.questionBody!)
        mockView.expectSetTags(expected.tags.joined(separator: ", "))
        
        mockRepository.expectGetProfileImageData(url: expected.ownerImageUrl, expectedImageData: nil, expectedError: ServiceError.noUrl)
        
        serviceUnderTest.configureView()
        
        XCTAssertEqual(mockRepository.expectedImageUrl, mockRepository.actualImageUrl)
    }
    
    func testConfigureViewGetProfileImageSuccessShouldSetOwnerProfileImage() {
        mockView.expectSetOwnerName(expected.ownerName)
        mockView.expectSetOwnerReputation(String(expected.ownerReputation!))
        mockView.expectSetQuestionDate("asked 1st January 1970 at 02:08")
        mockView.expectSetQuestionTitle(expected.title)
        mockView.expectSetQuestionBody(htmlString: expected.questionBody!)
        mockView.expectSetTags(expected.tags.joined(separator: ", "))
        
        let expectedImageData = Data()
        mockRepository.expectGetProfileImageData(url: expected.ownerImageUrl, expectedImageData: expectedImageData, expectedError: nil)
        mockView.expectSetOwnerProfileImage(imageData: expectedImageData)
        
        serviceUnderTest.configureView()
        
        XCTAssertEqual(mockRepository.expectedImageUrl, mockRepository.actualImageUrl)
    }
    
    func testConfigureViewShouldNotSetOwnerReputationIfOwnerReputationIsNil() {
        expected.ownerReputation = nil
        expected.ownerImageUrl = nil
        
        mockView.expectSetOwnerName(expected.ownerName)
        mockView.expectSetQuestionDate("asked 1st January 1970 at 02:08")
        mockView.expectSetQuestionTitle(expected.title)
        mockView.expectSetQuestionBody(htmlString: expected.questionBody!)
        mockView.expectSetTags(expected.tags.joined(separator: ", "))
        
        serviceUnderTest.configureView()
    }
    
    func testConfigureViewShouldNotSetQuetionDateIfQuestionDateIsNil() {
        expected.ownerReputation = nil
        expected.ownerImageUrl = nil
        expected.date = nil
        
        mockView.expectSetOwnerName(expected.ownerName)
        mockView.expectSetQuestionTitle(expected.title)
        mockView.expectSetQuestionBody(htmlString: expected.questionBody!)
        mockView.expectSetTags(expected.tags.joined(separator: ", "))
        
        serviceUnderTest.configureView()
    }
    
    func testConfigureViewShouldNotSetQuetionBodyIfQuestionBodyIsNil() {
        expected.ownerReputation = nil
        expected.ownerImageUrl = nil
        expected.date = nil
        expected.questionBody = nil
        
        mockView.expectSetOwnerName(expected.ownerName)
        mockView.expectSetQuestionTitle(expected.title)
        mockView.expectSetTags(expected.tags.joined(separator: ", "))
        
        serviceUnderTest.configureView()
    }
}
