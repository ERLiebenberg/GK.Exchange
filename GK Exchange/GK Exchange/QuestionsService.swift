//
//  QuestionsService.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/01.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias QuestionItemsResult = ([JSONDictionary]?, ServiceError?) -> ()
typealias ImageResult = (Data?, ServiceError?) -> ()

protocol QuestionService {
    
    func getQuestionItems(questionRequest: QuestionRequestModel, completion: @escaping QuestionItemsResult)
    
    func getImageFrom(url: URL, completion: @escaping ImageResult)
}
