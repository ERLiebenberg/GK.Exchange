//
//  MockSearchQuestionsRepository.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

@testable import GK_Exchange

class MockSearchRepository: SearchRepository {
    
    var searchCount = 0
    var expectedSearchTerm: String?
    var actualSearchTerm: String?
    var expectedQuestionModels: [QuestionModel]?
    var expectedSearchQuestionError: ServiceError?
    
    var getProfileImageCount = 0
    var expectedImageUrl: String?
    var actualImageUrl: String?
    var expectedImageData: Data?
    var expectedImageServiceError: ServiceError?
    
    func verify() -> Bool {
        return searchCount == 0 && getProfileImageCount == 0
    }
    
    func expectSearch(for searchTerm: String, expectedQuestionModels questionModels: [QuestionModel]?, expectedError error: ServiceError?) {
        searchCount += 1
        expectedSearchTerm = searchTerm
        expectedQuestionModels = questionModels
        expectedSearchQuestionError = error
    }
    
    func search(for searchTerm: String, completion: @escaping QuestionResult) {
        searchCount -= 1
        actualSearchTerm = searchTerm
        completion(expectedQuestionModels, expectedSearchQuestionError)
    }
    
    func expectGetProfileImageData(url: String?, expectedImageData imageData: Data?, expectedError error: ServiceError?) {
        getProfileImageCount -= 1
        expectedImageUrl = url
        expectedImageData = imageData
        expectedImageServiceError = error
    }
    
    func getProfileImageData(url: String, completion: @escaping ImageResult) {
        getProfileImageCount += 1
        actualImageUrl = url
        completion(expectedImageData, expectedImageServiceError)
    }
    
}
