//
//  SearchRepositoryImplementationTests.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import XCTest

@testable import GK_Exchange

class SearchRepositoryImplementationTests: XCTestCase  {
    
    var mockService = MockQuestionService()
    var serviceUnderTest: SearchRepositoryImplementation!
    
    private let testSearchTerm = "Search term"
    
    let testReputation: UInt = 300
    let testViewCount: UInt = 3
    let testAnswerCount: UInt = 26
    let testScoreCount: UInt = 7
    let testCreationDate: Double = 1535981943
    
    var testOwnerReputation: UInt = 300
    var testViews: UInt = 3
    var testAnswers: UInt = 26
    var testVotes: UInt = 7
    var testIsAnswered = true
    var testTags = ["ios", "swift", "xCode"]

    var testDate: Date? = Date(timeIntervalSince1970: 1535981943)
    let testOwnerName = "Display name value"
    let testOwnerImageUrl = "image Url value"
    let testTitle = "Question title value"
    let testQuestionBody = "Question Body value"
    
    override func setUp() {
        super.setUp()
        
        serviceUnderTest = SearchRepositoryImplementation(service: mockService)
    }
    
    override func tearDown() {
        XCTAssertTrue(mockService.verify())
        
        super.tearDown()
    }
    
    func testSearchTermFailureShouldCompleteWithErrorAndNoQuestionModels() {
        mockService.expectGetQuestionItems(expectedQuestionItems: nil, expectedError: ServiceError.noUrl)
        
        serviceUnderTest.search(for: testSearchTerm) { (questionModels, serviceError) in
            XCTAssertNil(questionModels)
            XCTAssertEqual(ServiceError.noUrl, serviceError)
        }
        
        let expected = QuestionRequestModel(searchTerm: testSearchTerm)
        let actual = mockService.actualQuestionRequestModel
        
        XCTAssertEqual(expected, actual)
    }
    
    func testSearchTermSuccessShouldCompleteWithNoErrorAndEmptyQuestionModelsWhenOwnerKeyCannotBeFoundInResponse() {
        let emptyDictionary = ["":""]
        mockService.expectGetQuestionItems(expectedQuestionItems: [emptyDictionary], expectedError: nil)
        
        serviceUnderTest.search(for: testSearchTerm) { (questionModels, serviceError) in
            XCTAssertTrue(questionModels?.count == 0)
            XCTAssertNil(serviceError)
        }
    }
    
    func testSearchTermSuccessShouldCompleteWithNoErrorAndExpectedQuestionModelsWhenScoreKeyCannotBeFoundInResponse() {
        let ownerDictionary = generateOwnerDictionary(reputation: testReputation, profileImage: testOwnerImageUrl, displayName: testOwnerName)
        let questionItemsDictionary: JSONDictionary = [
            "tags": testTags,
            "owner" : ownerDictionary,
            "is_answered":testIsAnswered,
            "view_count":testViewCount,
            "answer_count":testAnswerCount,
            "INVALID_score_INVALID":testScoreCount,
            "creation_date":testCreationDate,
            "title":testTitle,
            "body":testQuestionBody
        ]
        
        testVotes = 0
        
        let expected = generateQuestionModel(tags:testTags, ownerName: testOwnerName, ownerImageUrl:testOwnerImageUrl, isAnswered: testIsAnswered,
                                             views: testViews, votes: testVotes, answers: testAnswers, date: testDate, title: testTitle, questionBody: testQuestionBody, ownerReputation: testOwnerReputation)
        
        expectGetQuestionItems(questionItemsDictionary: questionItemsDictionary, questionModel: expected)
    }
    
    func testSearchTermSuccessShouldCompleteWithNoErrorAndExpectedQuestionModelsWhenAnswerCountKeyCannotBeFoundInResponse() {
        let ownerDictionary = generateOwnerDictionary(reputation: testReputation, profileImage: testOwnerImageUrl, displayName: testOwnerName)
        let questionItemsDictionary: JSONDictionary = [
            "tags": testTags,
            "owner" : ownerDictionary,
            "is_answered":testIsAnswered,
            "view_count":testViewCount,
            "INVALID_answer_count_INVALID":testAnswerCount,
            "score":testScoreCount,
            "creation_date":testCreationDate,
            "title":testTitle,
            "body":testQuestionBody
        ]
        
        testAnswers = 0
        
        let expected = generateQuestionModel(tags:testTags, ownerName: testOwnerName, ownerImageUrl:testOwnerImageUrl, isAnswered: testIsAnswered,
                                             views: testViews, votes: testVotes, answers: testAnswers, date: testDate, title: testTitle, questionBody: testQuestionBody, ownerReputation: testOwnerReputation)
        
        expectGetQuestionItems(questionItemsDictionary: questionItemsDictionary, questionModel: expected)
    }

    func testSearchTermSuccessShouldCompleteWithNoErrorAndExpectedQuestionModelsWhenViewCountKeyCannotBeFoundInResponse() {
        let ownerDictionary = generateOwnerDictionary(reputation: testReputation, profileImage: testOwnerImageUrl, displayName: testOwnerName)
        let questionItemsDictionary: JSONDictionary = [
            "tags": testTags,
            "owner" : ownerDictionary,
            "is_answered":testIsAnswered,
            "INVALID_view_count_INVALID":testViewCount,
            "answer_count":testAnswerCount,
            "score":testScoreCount,
            "creation_date":testCreationDate,
            "title":testTitle,
            "body":testQuestionBody
        ]
        
        testViews = 0
        
        let expected = generateQuestionModel(tags:testTags, ownerName: testOwnerName, ownerImageUrl:testOwnerImageUrl, isAnswered: testIsAnswered,
                                             views: testViews, votes: testVotes, answers: testAnswers, date: testDate, title: testTitle, questionBody: testQuestionBody, ownerReputation: testOwnerReputation)
        
        expectGetQuestionItems(questionItemsDictionary: questionItemsDictionary, questionModel: expected)
    }
    
    func testSearchTermSuccessShouldSetIsAnsweredToFalseIfAnswerKeyCannotBeFoundInResponse() {
        let ownerDictionary = generateOwnerDictionary(reputation: testReputation, profileImage: testOwnerImageUrl, displayName: testOwnerName)
        let questionItemsDictionary: JSONDictionary = [
            "tags": testTags,
            "owner" : ownerDictionary,
            "INVALID_is_answered_INVALID":true,
            "view_count":testViewCount,
            "answer_count":testAnswerCount,
            "score":testScoreCount,
            "creation_date":testCreationDate,
            "title":testTitle,
            "body":testQuestionBody
        ]
        
        testIsAnswered = false
        
        let expected = generateQuestionModel(tags:testTags, ownerName: testOwnerName, ownerImageUrl:testOwnerImageUrl, isAnswered: testIsAnswered,
                                             views: testViews, votes: testVotes, answers: testAnswers, date: testDate, title: testTitle, questionBody: testQuestionBody, ownerReputation: testOwnerReputation)
        
        expectGetQuestionItems(questionItemsDictionary: questionItemsDictionary, questionModel: expected)
    }
    
    func testSearchTermSuccessShouldCompleteWithNoErrorAndExpectedQuestionModelsWhenTagsKeyCannotBeFoundInResponse() {
        let ownerDictionary = generateOwnerDictionary(reputation: testReputation, profileImage: testOwnerImageUrl, displayName: testOwnerName)
        let questionItemsDictionary: JSONDictionary = [
            "INVALID_tags_INVALID": ["other tags"],
            "owner" : ownerDictionary,
            "is_answered":testIsAnswered,
            "view_count":testViewCount,
            "answer_count":testAnswerCount,
            "score":testScoreCount,
            "creation_date":testCreationDate,
            "title":testTitle,
            "body":testQuestionBody
        ]
        
        testTags = [""]
        
        let expected = generateQuestionModel(tags:testTags, ownerName: testOwnerName, ownerImageUrl:testOwnerImageUrl, isAnswered: testIsAnswered,
                                             views: testViews, votes: testVotes, answers: testAnswers, date: testDate, title: testTitle, questionBody: testQuestionBody, ownerReputation: testOwnerReputation)
        
        expectGetQuestionItems(questionItemsDictionary: questionItemsDictionary, questionModel: expected)
    }
    
    func testSearchTermSuccessShouldCompleteWithNoErrorAndExpectedQuestionModelsWhenDateKeyCannotBeFoundInResponse() {
        let ownerDictionary = generateOwnerDictionary(reputation: testReputation, profileImage: testOwnerImageUrl, displayName: testOwnerName)
        let questionItemsDictionary: JSONDictionary = [
            "tags": testTags,
            "owner" : ownerDictionary,
            "is_answered":testIsAnswered,
            "view_count":testViewCount,
            "answer_count":testAnswerCount,
            "score":testScoreCount,
            "INVALID_creation_date_INVALID":testCreationDate,
            "title":testTitle,
            "body":testQuestionBody
        ]
        
        testDate = nil
        
        let expected = generateQuestionModel(tags:testTags, ownerName: testOwnerName, ownerImageUrl:testOwnerImageUrl, isAnswered: testIsAnswered,
                                             views: testViews, votes: testVotes, answers: testAnswers, date: testDate, title: testTitle, questionBody: testQuestionBody, ownerReputation: testOwnerReputation)
        
        expectGetQuestionItems(questionItemsDictionary: questionItemsDictionary, questionModel: expected)
    }
    
    // MARK: Get Image Data Tests
    func testGetProfileImageDataFailureShouldCompleteWithError() {
        mockService.expectgetImageFrom(url: URLComponents(string: "Http://stack.co.za")!.url, expectedImageData: nil, expectedError: ServiceError.noUrl)
        
        serviceUnderTest.getProfileImageData(url: "Http://stack.co.za") { (imageData, error) in
            XCTAssertNil(imageData)
            XCTAssertEqual(ServiceError.noUrl, error)
        }
        
        XCTAssertEqual(mockService.expectedUrl, mockService.actualUrl)
    }
    
    func testGetProfileImageDataSuccessShouldCompleteWithImageData() {
        let expected = Data()
        
        mockService.expectgetImageFrom(url: URLComponents(string: "Http://stack.co.za")!.url, expectedImageData: expected, expectedError: nil)
        
        serviceUnderTest.getProfileImageData(url: "Http://stack.co.za") { (imageData, error) in
            XCTAssertEqual(expected, imageData)
            XCTAssertNil(error)
        }
        
        XCTAssertEqual(mockService.expectedUrl, mockService.actualUrl)
    }
}

extension SearchRepositoryImplementationTests {
    
    func expectGetQuestionItems(questionItemsDictionary: JSONDictionary, questionModel expected: QuestionModel) {
        mockService.expectGetQuestionItems(expectedQuestionItems: [questionItemsDictionary], expectedError: nil)
        
        serviceUnderTest.search(for: testSearchTerm) { (questionModels, serviceError) in
            XCTAssertEqual([expected], questionModels)
            XCTAssertNil(serviceError)
        }
    }
    
    func generateQuestionModel(tags: [String], ownerName: String, ownerImageUrl: String, isAnswered: Bool, views: UInt, votes: UInt,
                               answers: UInt, date: Date?, title: String, questionBody: String, ownerReputation: UInt) -> QuestionModel {
        let questionModel = QuestionModel()
        questionModel.tags = tags
        questionModel.ownerName = ownerName
        questionModel.ownerImageUrl = ownerImageUrl
        questionModel.isAnswered = isAnswered
        questionModel.views = views
        questionModel.votes = votes
        questionModel.answers = answers
        questionModel.date = date
        questionModel.title = title
        questionModel.questionBody = questionBody
        questionModel.ownerReputation = ownerReputation
        
        return questionModel
    }
    
    func generateOwnerDictionary(reputation: UInt, profileImage: String, displayName: String) -> JSONDictionary {
        return ["reputation":reputation,
                "profile_image":profileImage,
                "display_name":displayName]
    }
}
