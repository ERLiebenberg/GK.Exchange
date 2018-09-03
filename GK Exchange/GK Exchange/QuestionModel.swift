//
//  QuestionModel.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/08/29.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import UIKit

class QuestionModel {
    
    var tags: [String] = [""]
    var title: String?
    var votes: UInt = 0
    var answers: UInt = 0
    var views: UInt = 0
    var isAnswered: Bool = false
    var date: Date?
    var questionBody: String?
    
    var ownerName: String?
    var ownerImageUrl: String?
    var ownerReputation: UInt?
}

extension QuestionModel: Equatable {
    
    public static func == (lhs: QuestionModel, rhs: QuestionModel) -> Bool {
        return lhs.tags == rhs.tags &&
        lhs.title == rhs.title &&
        lhs.votes == rhs.votes &&
        lhs.answers == rhs.answers &&
        lhs.views == rhs.views &&
        lhs.isAnswered == rhs.isAnswered &&
        lhs.date == rhs.date &&
        lhs.questionBody == rhs.questionBody &&
        lhs.ownerName == rhs.ownerName &&
        lhs.ownerImageUrl == rhs.ownerImageUrl &&
        lhs.ownerReputation == rhs.ownerReputation
    }
}

