//
//  QuestionViewModel.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/01.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import UIKit

class QuestionViewModel {
    
    private let commaSeparator = ", "
    private let dateAskedTitle = NSLocalizedString("search.questions.dateAsked.title", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
    
    private weak var view: QuestionView?
    private var questionModel: QuestionModel?
    private var repository: SearchRepository
    
    init(view: QuestionView, questionModel: QuestionModel?, repository: SearchRepository = SearchRepositoryImplementation.repository) {
        self.view = view
        self.questionModel = questionModel
        self.repository = repository
    }
    
    func configureView() {
        guard let questionModel = questionModel else {
            return
        }
    
        configureOwnerProfileSection(questionModel: questionModel)
        configureQuestionSection(questionModel: questionModel)
        view?.setTags(questionModel.tags.joined(separator: commaSeparator))
    }
    
    private func configureQuestionSection(questionModel: QuestionModel) {
        view?.setQuestionTitle(questionModel.title)
        
        if let questionBody = questionModel.questionBody {
            view?.setQuestionBody(htmlString: questionBody)
        }
    }
    
    private func configureOwnerProfileSection(questionModel: QuestionModel) {
        if let ownerImageUrl = questionModel.ownerImageUrl {
            getOwnerProfileImage(url: ownerImageUrl)
        }
        
        view?.setOwnerName(questionModel.ownerName)

        if let ownerReputation = questionModel.ownerReputation {
            view?.setOwnerReputation(String(ownerReputation))
        }

        if let questionDate = questionModel.date {
            view?.setQuestionDate(dateAskedTitle + singleSpace + questionDate.dateFormattedDaySuffix())
        }
    }
    
    private func getOwnerProfileImage(url: String) {
        repository.getProfileImageData(url: url) { (imageData, error) in
            guard let imageData = imageData, error == nil else {
                return
            }
            
            self.view?.setOwnerProfileImage(imageData:imageData)
        }
    }
}
