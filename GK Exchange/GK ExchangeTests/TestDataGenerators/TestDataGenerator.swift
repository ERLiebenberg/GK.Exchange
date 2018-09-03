//
//  TestDataGenerator.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

@testable import GK_Exchange

class TestDataGenerator {

    static func generateQuestionModel() -> QuestionModel {
        let questionModel = QuestionModel()
        questionModel.tags = ["ios, swift, xcode"]
        questionModel.title = "How can I see xCode"
        questionModel.votes = 2
        questionModel.answers = 4
        questionModel.views = 6
        questionModel.isAnswered = true
        questionModel.date = Date(timeIntervalSince1970: 500)
        questionModel.questionBody = "questionBody"
        questionModel.ownerName = "Freddie"
        questionModel.ownerImageUrl = "owner url"
        questionModel.ownerReputation = 10
        
        return questionModel
    }
    
    static func generateQuestionItemDictionary() -> JSONDictionary {
        return [
            "tags": 1,
            "owner" : ["":""],
            "is_answered":true,
            "view_count":30,
            "answer_count":20,
            "INVALID_score_INVALID":22,
            "creation_date":23234,
            "title":"title",
            "body":"body"
        ]
    }
}
