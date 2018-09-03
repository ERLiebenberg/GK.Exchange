//
//  MockAsynchronousRunner.swift
//  GK ExchangeTests
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

@testable import GK_Exchange

class MockAsynchronousRunner: AsynchronousRunner {
    
    func runOnMain(_ action: @escaping () -> ()) {
        action()
    }
}
