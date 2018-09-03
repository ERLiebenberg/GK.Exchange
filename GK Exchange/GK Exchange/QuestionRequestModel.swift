//
//  QuestionRequestModel.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/02.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

class QuestionRequestModel {
    
    let searchTerm: String
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
    }
}

extension QuestionRequestModel: Equatable {
    
    public static func == (lhs: QuestionRequestModel, rhs: QuestionRequestModel) -> Bool {
        return lhs.searchTerm == rhs.searchTerm
    }
    
}
