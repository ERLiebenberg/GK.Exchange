//
//  AsyncProvider.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

protocol AsynchronousRunner {
    
    func runOnMain(_ action: @escaping () -> ())
}

class AsynchronousRunnerImplementation: AsynchronousRunner {

    func runOnMain(_ action: @escaping () -> ()) {
        DispatchQueue.main.async(execute: action)
    }
}
