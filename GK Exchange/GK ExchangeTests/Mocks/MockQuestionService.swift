//
//  MockQuestionService.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

@testable import GK_Exchange

class MockQuestionService: QuestionService {
    
    var getQuestionItemsCount = 0
    var getImageUrlCount = 0
    
    var expectedQuestionRequestModel: QuestionRequestModel?
    var actualQuestionRequestModel: QuestionRequestModel?
    
    var expectedQuestionItems: [JSONDictionary]?
    var actualQuestionItems: [JSONDictionary]?
    var expectedGetQuestionItemsServiceError: ServiceError?
    
    var expectedImageData: Data?
    var actualImageData: Data?
    var expectedImageServiceError: ServiceError?
    
    var expectedUrl: URL?
    var actualUrl: URL?
    
    func verify() -> Bool {
        return getQuestionItemsCount == 0 && getImageUrlCount == 0
    }
    
    func expectGetQuestionItems(expectedQuestionItems questionItems: [JSONDictionary]?, expectedError error: ServiceError?) {
        getQuestionItemsCount -= 1
        expectedQuestionItems = questionItems
        expectedGetQuestionItemsServiceError = error
    }
    
    func getQuestionItems(questionRequest: QuestionRequestModel, completion: @escaping QuestionItemsResult) {
        getQuestionItemsCount += 1
        actualQuestionRequestModel = questionRequest
        completion(expectedQuestionItems, expectedGetQuestionItemsServiceError)
    }
    
    func expectgetImageFrom(url: URL?, expectedImageData imageData: Data?, expectedError error: ServiceError?) {
        getImageUrlCount -= 1
        expectedUrl = url
        expectedImageData = imageData
        expectedImageServiceError = error
    }
    
    func getImageFrom(url: URL, completion: @escaping ImageResult) {
        getImageUrlCount += 1
        actualUrl = url
        completion(expectedImageData, expectedImageServiceError)
    }
}
