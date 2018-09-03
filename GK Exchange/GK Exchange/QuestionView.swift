//
//  QuestionView.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/01.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

protocol QuestionView: class {
    
    func setQuestionTitle(_ title: String?)

    func setQuestionBody(htmlString: String)

    func setTags(_ tags: String)

    func setOwnerProfileImage(imageData: Data)
    
    func setOwnerName(_ ownerName: String?)
    
    func setOwnerReputation(_ ownerReputation: String)
    
    func setQuestionDate(_ date: String)
    
}
