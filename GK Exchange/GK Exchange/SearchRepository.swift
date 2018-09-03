//
//  SearchRepository.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/02.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

typealias QuestionResult = ([QuestionModel]?, ServiceError?) -> ()

protocol SearchRepository {
    
    func search(for searchTerm: String, completion: @escaping QuestionResult)
    
    func getProfileImageData(url: String, completion: @escaping ImageResult)
    
}
