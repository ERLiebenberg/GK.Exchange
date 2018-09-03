//
//  MockQuestionView.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

@testable import GK_Exchange

class MockQuestionView: QuestionView {
    
    private var setQuestionTitleCount = 0
    private var setQuestionBodyCount = 0
    private var setTagsCount = 0
    private var setOwnerProfileImageCount = 0
    private var setOwnerNameCount = 0
    private var setOwnerReputationCount = 0
    private var setQuestionDateCount = 0
    
    var expectedQuestionTitle: String?
    var actualQuestionTitle: String?
    
    var expectedQuestionBody: String?
    var actualQuestionBody: String?
    
    var expectedTags: String?
    var actualTags: String?
    
    var expectedOwnerProfileImageData: Data?
    var actualOwnerProfileImageData: Data?
    
    var expectedOwnerName: String?
    var actualOwnerName: String?
    
    var expectedOwnerReputation: String?
    var actualOwnerReputation: String?
    
    var expectedQuestionDate: String?
    var actualQuestionDate: String?
    
    func verify() -> Bool {
        return setQuestionTitleCount == 0 &&
        setQuestionBodyCount == 0 &&
        setTagsCount == 0 &&
        setOwnerProfileImageCount == 0 &&
        setOwnerNameCount == 0 &&
        setOwnerReputationCount == 0 &&
        setQuestionDateCount == 0
    }
    
    func expectSetQuestionTitle(_ title: String?) {
        setQuestionTitleCount -= 1
        expectedQuestionTitle = title
    }
    
    func setQuestionTitle(_ title: String?) {
        setQuestionTitleCount += 1
        actualQuestionTitle = title
    }
    
    func expectSetQuestionBody(htmlString: String) {
        setQuestionBodyCount -= 1
        expectedQuestionBody = htmlString
    }
    
    func setQuestionBody(htmlString: String) {
       setQuestionBodyCount += 1
        actualQuestionBody = htmlString
    }
    
    func expectSetTags(_ tags: String) {
        setTagsCount -= 1
        expectedTags = tags
    }
    
    func setTags(_ tags: String) {
        setTagsCount += 1
        actualTags = tags
    }
    
    func expectSetOwnerProfileImage(imageData: Data) {
        setOwnerProfileImageCount -= 1
        expectedOwnerProfileImageData = imageData
    }
    
    func setOwnerProfileImage(imageData: Data) {
        setOwnerProfileImageCount += 1
        actualOwnerProfileImageData = imageData
    }
    
    func expectSetOwnerName(_ ownerName: String?) {
        setOwnerNameCount -= 1
        expectedOwnerName = ownerName
    }
    
    func setOwnerName(_ ownerName: String?) {
        setOwnerNameCount += 1
        actualOwnerName = ownerName
    }
    
    func expectSetOwnerReputation(_ ownerReputation: String) {
        setOwnerReputationCount -= 1
        expectedOwnerReputation = ownerReputation
    }
    
    func setOwnerReputation(_ ownerReputation: String) {
        setOwnerReputationCount += 1
        actualOwnerReputation = ownerReputation
    }

    func expectSetQuestionDate(_ date: String) {
        setQuestionDateCount -= 1
        expectedQuestionDate = date
    }
    
    func setQuestionDate(_ date: String) {
        setQuestionDateCount += 1
        actualQuestionDate = date
    }
}
