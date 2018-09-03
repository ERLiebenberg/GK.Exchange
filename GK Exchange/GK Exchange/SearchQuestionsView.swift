//
//  SearchQuestionsView.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/08/29.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

protocol SearchQuestionsView: class {
    
    func reloadTableView()
    
    func presentErrorMessage(_ errorMessage: String?)
    
}
