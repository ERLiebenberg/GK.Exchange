//
//  SearchQuestionsViewModelTests.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/08/29.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import XCTest

@testable import GK_Exchange

class SearchQuestionsViewModelTests: XCTestCase {
    
    var mockView = MockSearchQuestionsView()
    var mockSearchRepository = MockSearchRepository()
    
    var serviceUnderTest: SearchQuestionsViewModel!
    
    override func setUp() {
        super.setUp()
        
        serviceUnderTest = SearchQuestionsViewModel(view: mockView, repository: mockSearchRepository)
    }
    
    override func tearDown() {
        XCTAssertTrue(mockView.verify())
        XCTAssertTrue(mockSearchRepository.verify())
        
        super.tearDown()
    }
    
    func testSearchShouldNotSearhIfSearchTermIsNil() {
        serviceUnderTest.searchQuestions(query: nil)
        
        XCTAssertTrue(mockSearchRepository.verify())
    }
    
    func testSearchShouldNotSearhIfSearchTermIsEmpty() {
        serviceUnderTest.searchQuestions(query: "")
        
        XCTAssertTrue(mockSearchRepository.verify())
    }
    
    func testSearchShouldDisplayErrorMessage() {
        mockView.expectPresentErrorMessage(ServiceError.noResponseData.localizedDescription)
        mockSearchRepository.expectSearch(for: "iOS", expectedQuestionModels: nil, expectedError: ServiceError.noResponseData)
        
        serviceUnderTest.searchQuestions(query: "iOS")
        
        XCTAssertEqual(mockView.expectedErrorMessage, mockView.actualErrorMessage)
        XCTAssertEqual(mockSearchRepository.expectedSearchTerm, mockSearchRepository.actualSearchTerm)
    }
    
    func testSearchShouldUpdateSearchModelsAndReloadTableView() {
        let questionModels = [TestDataGenerator.generateQuestionModel()]
        mockSearchRepository.expectSearch(for: "iOS", expectedQuestionModels: questionModels, expectedError: nil)
        mockView.expectReloadTableView()
        
        serviceUnderTest.searchQuestions(query: "iOS")
        
        XCTAssertEqual(mockSearchRepository.expectedSearchTerm, mockSearchRepository.actualSearchTerm)
        XCTAssertEqual(questionModels.count, serviceUnderTest.questionsCount())
    }
    
    func testQuestionAtIndexShouldReturnNilIfIndexIsOutOfRange() {
        XCTAssertNil(serviceUnderTest.question(at: 999))
    }
    
    func testQuestionAtIndexShouldReturnExpectedQuestion() {
        let expected = TestDataGenerator.generateQuestionModel()
        expectGetQuestionModels([expected])
        
        let actual = serviceUnderTest.question(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testTitleAtIndexShouldReturnNilIfIndexIsOutOfRange() {
        XCTAssertNil(serviceUnderTest.title(at: 999))
    }
    
    func testTitleAtIndexShouldReturnExpectedTitle() {
        let questionModel = TestDataGenerator.generateQuestionModel()
        expectGetQuestionModels([questionModel])
        
        let expected = questionModel.title
        let actual = serviceUnderTest.title(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testOwnerNameAtIndexShouldReturnNilIfIndexIsOutOfRange() {
        XCTAssertNil(serviceUnderTest.ownerName(at: 999))
    }
    
    func testOwnerNameAtIndexShouldReturnExpectedOwnerName() {
        let questionModel = TestDataGenerator.generateQuestionModel()
        expectGetQuestionModels([questionModel])
        
        let expected = "asked by: " + questionModel.ownerName!
        let actual = serviceUnderTest.ownerName(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfVotesAtIndexShouldReturnNilIfIndexIsOutOfRange() {
        XCTAssertNil(serviceUnderTest.numberOfViews(at: 999))
    }
    
    func testNumberOfVotesAtIndexShouldReturnExpectedTitleForASingleVote() {
        let questionModel = TestDataGenerator.generateQuestionModel()
        questionModel.votes = 1
        
        expectGetQuestionModels([questionModel])
        
        let expected = "1 Vote"
        let actual = serviceUnderTest.numberOfVotes(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfVotesAtIndexShouldReturnExpectedTitleForMultipleVotes() {
        let questionModel = TestDataGenerator.generateQuestionModel()
        questionModel.votes = 20
        
        expectGetQuestionModels([questionModel])
        
        let expected = "20 Votes"
        let actual = serviceUnderTest.numberOfVotes(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfAnswersAtIndexShouldReturnNilIfIndexIsOutOfRange() {
        XCTAssertNil(serviceUnderTest.numberOfViews(at: 999))
    }
    
    func testNumberOfAnswersAtIndexShouldReturnExpectedTitleForASingleAnswer() {
        let questionModel = TestDataGenerator.generateQuestionModel()
        questionModel.answers = 1
        
        expectGetQuestionModels([questionModel])
        
        let expected = "1 Answer"
        let actual = serviceUnderTest.numberOfAnswers(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfAnswersAtIndexShouldReturnExpectedTitleForMultipleAnswers() {
        let questionModel = TestDataGenerator.generateQuestionModel()
        questionModel.answers = 20
        
        expectGetQuestionModels([questionModel])
        
        let expected = "20 Answers"
        let actual = serviceUnderTest.numberOfAnswers(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfViewsAtIndexShouldReturnNilIfIndexIsOutOfRange() {
        XCTAssertNil(serviceUnderTest.numberOfViews(at: 999))
    }
    
    func testNumberOfViewsAtIndexShouldReturnExpectedTitleForASingleView() {
        let questionModel = TestDataGenerator.generateQuestionModel()
        questionModel.views = 1
        
        expectGetQuestionModels([questionModel])
        
        let expected = "1 View"
        let actual = serviceUnderTest.numberOfViews(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfViewsAtIndexShouldReturnExpectedTitleForMultipleViews() {
        let questionModel = TestDataGenerator.generateQuestionModel()
        questionModel.views = 20
        
        expectGetQuestionModels([questionModel])
        
        let expected = "20 Views"
        let actual = serviceUnderTest.numberOfViews(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testIsQuestionAnsweredShouldReturnFalseIfIndexIsOUtOfRange() {
        XCTAssertFalse(serviceUnderTest.isQuestionAnswered(at: 999))
    }
    
    func testIsQuestionAnsweredShouldReturnExpectedValue() {
        let questionModel = TestDataGenerator.generateQuestionModel()
        expectGetQuestionModels([questionModel])
        
        let expected = true
        let actual = serviceUnderTest.isQuestionAnswered(at: 0)
        
        XCTAssertEqual(expected, actual)
    }
}

extension SearchQuestionsViewModelTests {
    
    func expectGetQuestionModels(_ questionModels: [QuestionModel]) {
        mockSearchRepository.expectSearch(for: "Generic Search Term", expectedQuestionModels: questionModels, expectedError: nil)
        mockView.expectReloadTableView()
        serviceUnderTest.searchQuestions(query: "Generic Search Term")
    }
}
