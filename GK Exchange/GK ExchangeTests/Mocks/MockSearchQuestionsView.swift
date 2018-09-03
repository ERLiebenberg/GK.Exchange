//
//  MockSearchQuestionsView.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

@testable import GK_Exchange

class MockSearchQuestionsView: SearchQuestionsView {
    
    private var reloadTableViewCount = 0
    private var presentErrorMessageCount = 0
    
    var expectedErrorMessage: String?
    var actualErrorMessage: String?
    
    func verify() -> Bool {
        return reloadTableViewCount == 0 && presentErrorMessageCount == 0
    }
    
    func expectReloadTableView() {
        reloadTableViewCount -= 1
    }
    
    func reloadTableView() {
        reloadTableViewCount += 1
    }
    
    func expectPresentErrorMessage(_ errorMessage: String?) {
        presentErrorMessageCount += 1
        expectedErrorMessage = errorMessage
    }
    
    func presentErrorMessage(_ errorMessage: String?) {
        presentErrorMessageCount -= 1
        actualErrorMessage = errorMessage
    }
}
