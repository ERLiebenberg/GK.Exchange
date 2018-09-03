//
//  QuestionsServiceImplementation.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

final class QuestionsServiceImplementation {
    
    static var service = QuestionsServiceImplementation()
    
    private var dataTask: URLSessionDataTask?
    private let factory: ServiceFactory
    
    init(factory: ServiceFactory = ServiceFactoryImplementation()) {
        self.factory = factory
    }

    fileprivate func retrieveQuestionItems(url: URL, completion: @escaping QuestionItemsResult) {
        factory.dataTask?.cancel()
        
        factory.makeDataTask(url: url, completion: { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.factory.asynchronousRunner.runOnMain({
                    completion(nil, ServiceError.noResponseData)
                })
                return
            }
            
            var responseDictionary: JSONDictionary?

            do {
                responseDictionary = try self.factory.serializeJSON(data: data)
            } catch {
                self.factory.asynchronousRunner.runOnMain({
                    completion(nil, ServiceError.parseError)
                })
            }

            guard let items = responseDictionary?["items"] as? [JSONDictionary] else {
                self.factory.asynchronousRunner.runOnMain({
                    completion(nil, ServiceError.parseError)
                })
                return
            }

            self.factory.asynchronousRunner.runOnMain({
                completion(items, nil)
            })
        })
        
       factory.dataTask?.resume()
    }
    
    fileprivate func retrieveImage(url: URL, completion: @escaping ImageResult) {
        factory.dataTask?.cancel()
        
        factory.makeDataTask(url: url, completion: { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.factory.asynchronousRunner.runOnMain({
                    completion(nil, ServiceError.noResponseData)
                })
                return
            }
            
            self.factory.asynchronousRunner.runOnMain({
                completion(data, nil)
            })
        })
        factory.dataTask?.resume()
    }
}

extension QuestionsServiceImplementation: QuestionService {
    
    func getQuestionItems(questionRequest: QuestionRequestModel, completion: @escaping QuestionItemsResult) {
        guard let url = factory.makeSearchUrl(query: "pagesize=20&order=desc&sort=activity&tagged=\(questionRequest.searchTerm)&site=stackoverflow&filter=withbody") else {
            completion(nil, ServiceError.noUrl)
            return
        }
        
        retrieveQuestionItems(url: url, completion: completion)
    }
    
    func getImageFrom(url: URL, completion: @escaping ImageResult) {
        retrieveImage(url: url, completion: completion)
    }
}
