//
//  SearchQuestionsViewModel.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/08/29.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

let singleSpace = " "

class SearchQuestionsViewModel {
    
    private let voteTitle = NSLocalizedString("search.questions.vote.title", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
    private let votesTitle = NSLocalizedString("search.questions.votes.title", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
    private let answerTitle = NSLocalizedString("search.questions.answer.title", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
    private let answersTitle = NSLocalizedString("search.questions.answers.title", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
    private let viewTitle = NSLocalizedString("search.questions.view.title", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
    private let viewsTitle = NSLocalizedString("search.questions.views.title", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
    private let ownerPrefixTitle = NSLocalizedString("search.questions.ownerPrefix.title", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
    
    private weak var view: SearchQuestionsView?
    private var repository: SearchRepository
    private var questionModels: [QuestionModel] = []

    init(view: SearchQuestionsView, repository: SearchRepository = SearchRepositoryImplementation.repository) {
        self.view = view
        self.repository = repository
    }
    
    func searchQuestions(query: String?) {
        guard let query = query, !query.isEmpty else {
            return
        }
        
        repository.search(for: query) { (questions, error) in
            guard let questions = questions, error == nil else {
                self.view?.presentErrorMessage(error?.localizedDescription)
                return
            }
            
            self.questionModels = questions
            self.view?.reloadTableView()
        }
    }

    func questionsCount() -> Int {
        return questionModels.count
    }
    
    func question(at index: Int) -> QuestionModel? {
        return indexIsInRange(index: index) ? questionModels[index] : nil
    }
    
    func title(at index: Int) -> String? {
        return indexIsInRange(index: index) ? questionModels[index].title : nil
    }
    
    func ownerName(at index: Int) -> String? {
        if indexIsInRange(index: index), let ownerName = questionModels[index].ownerName {
            return ownerPrefixTitle + singleSpace  + ownerName
        }
        
        return nil
    }
    
    func numberOfVotes(at index: Int) -> String? {
        if indexIsInRange(index: index) {
            return questionModels[index].votes == 1 ?
                String(questionModels[index].votes) + singleSpace + voteTitle :
                String(questionModels[index].votes) + singleSpace + votesTitle
        }
        
        return nil
    }
    
    func numberOfAnswers(at index: Int) -> String? {
        if indexIsInRange(index: index) {
            return questionModels[index].answers == 1 ?
                String(questionModels[index].answers) + singleSpace + answerTitle :
                String(questionModels[index].answers) + singleSpace + answersTitle
        }
        
        return nil
    }
    
    func numberOfViews(at index: Int) -> String? {
        if indexIsInRange(index: index) {
            return questionModels[index].views == 1 ?
                String(questionModels[index].views) + singleSpace + viewTitle :
                String(questionModels[index].views) + singleSpace + viewsTitle
        }
        
        return nil
    }
    
    func isQuestionAnswered(at index: Int) -> Bool {
        return indexIsInRange(index:index) ? questionModels[index].isAnswered : false
    }
    
    private func indexIsInRange(index: Int) -> Bool {
        return index < questionModels.count
    }
}
