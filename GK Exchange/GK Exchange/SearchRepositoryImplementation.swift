//
//  SearchQuestionsRepositoryImplementation.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/08/29.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import UIKit

final class SearchRepositoryImplementation {
    
    static var repository = SearchRepositoryImplementation()
    private var questionService: QuestionService
    
    init(service: QuestionService = QuestionsServiceImplementation.service) {
        self.questionService = service
    }

    fileprivate func createQuestionModels(items: [JSONDictionary]) -> [QuestionModel] {
        var questions = [QuestionModel]()
        
        for questionDictionary in items {
            if let ownerDictionary = questionDictionary["owner"] as? JSONDictionary  {
                questions.append(createQuestionModel(questionDictionary: questionDictionary, ownerDictionary: ownerDictionary))
            }
        }
        
        return questions
    }
    
    private func createQuestionModel(questionDictionary: JSONDictionary, ownerDictionary: JSONDictionary) -> QuestionModel {
            let question = QuestionModel()
            if let numberOfVotes = questionDictionary["score"] as? UInt {
                question.votes = numberOfVotes
            }
            
            if let numberOfAnswers = questionDictionary["answer_count"] as? UInt {
                question.answers = numberOfAnswers
            }
            
            if let numberOfViews = questionDictionary["view_count"] as? UInt {
                question.views = numberOfViews
            }
            
            if let isAnswered = questionDictionary["is_answered"] as? Bool {
                question.isAnswered = isAnswered
            }
            
            if let tags = questionDictionary["tags"] as? [String] {
                question.tags = tags
            }
            
            if let questionDate = questionDictionary["creation_date"] as? Double {
                question.date = Date(timeIntervalSince1970: questionDate)
            }

            question.title = questionDictionary["title"] as? String
            question.questionBody = questionDictionary["body"] as? String
            question.ownerImageUrl = ownerDictionary["profile_image"] as? String
            question.ownerName = ownerDictionary["display_name"] as? String
            question.ownerReputation = ownerDictionary["reputation"] as? UInt
            
            return question
    }
}

extension SearchRepositoryImplementation: SearchRepository {
    
    func search(for searchTerm: String, completion: @escaping QuestionResult) {
        let request = QuestionRequestModel(searchTerm: searchTerm)
        
        questionService.getQuestionItems(questionRequest: request, completion: { (items, error) in
            guard let items = items, error == nil else {
                completion(nil, error)
                return
            }
            
            completion(self.createQuestionModels(items: items), nil)
        })
    }
    
    func getProfileImageData(url: String, completion: @escaping ImageResult) {
        guard let urlComponents = URLComponents(string: url), let url = urlComponents.url else {
            completion(nil, ServiceError.noUrl)
            return
        }
        
        questionService.getImageFrom(url: url, completion: completion)
    }
}
