//
//  ServiceError.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    
    case noUrl
    case noResponseData
    case parseError
    
}

extension ServiceError {
    
    var localizedDescription: String {
        switch self {
        case .noUrl:
            return "There was a problem creating the url"
        case .noResponseData:
            return "No response data found"
        case .parseError:
            return "Parse error"
        }
    }
}
