//
//  ServiceFactory.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

protocol ServiceFactory {
    
    var dataTask: URLSessionDataTask? { get }
    
    var asynchronousRunner: AsynchronousRunner { get }
    
    func makeDataTask(url: URL, completion: @escaping (Data?, Any?, Error?) -> ())
    
    func makeSearchUrl(query: String) -> URL?
    
    func serializeJSON(data: Data) throws -> JSONDictionary?
}

class ServiceFactoryImplementation: ServiceFactory {
    
    var dataTask: URLSessionDataTask? = nil
    
    var asynchronousRunner: AsynchronousRunner = AsynchronousRunnerImplementation()
    
    func makeDataTask(url: URL, completion: @escaping (Data?, Any?, Error?) -> ()) {
        dataTask = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
    }
    
    func makeSearchUrl(query: String) -> URL? {
        if var urlComponents = URLComponents(string: "https://api.stackexchange.com/2.2/questions") {
            urlComponents.query = query
            if let url = urlComponents.url {
                return url
            }
        }
        
        return nil
    }
    
    func serializeJSON(data: Data) throws -> JSONDictionary? {
        return try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    }
}
