//
//  BookStoreService.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

typealias ResultBookStoreList = Result<(BookStoreContainer), NetworkError>

class BookStoreService: Service {
    
    //
    // MARK: - Properties
    var client: NetworkClient
    
    //
    // MARK: - Initializer DI
    required init(client: NetworkClient) {
        self.client = client
    }
    
    //
    // MARK: - Public Functions
    
    /// Load book list
    /// - Parameters:
    ///   - search: query string
    ///   - maxResults: String
    ///   - startIndex: page String
    ///   - completion: Closure
    func bookList(search: String, maxResults: String, startIndex: String, completion: @escaping (ResultBookStoreList) -> Void) {
        client.request(router: BookStoreRouter.book(query: search, maxResults: maxResults, startIndex: startIndex), returnType: BookStoreContainer.self) { result in
            completion(result)
        }
    }
}
