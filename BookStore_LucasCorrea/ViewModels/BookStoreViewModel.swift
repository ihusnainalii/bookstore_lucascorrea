//
//  BookStoreViewModel.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

class BookStoreViewModel {
    
    //
    // MARK: - Properties
    var bookItems: [Book]
    var service: BookStoreService
    
    //
    // MARK: - Initializer DI
    init(service: BookStoreService = BookStoreService(client: BookStoreClient())) {
        self.service = service
        self.bookItems = [Book]()
    }
    
    //
       // MARK: - Public Functions
       
       /// Station list
       /// - Parameters:
       ///   - success: Closure Void
       ///   - failure: Closure Errors
    func bookStoreList(search: String, maxResults: String, startIndex: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
           self.service.bookList(search: search, maxResults: maxResults, startIndex: startIndex) { result in
               switch result {
               case .success(let bookStoreContainer):
                   self.bookItems = bookStoreContainer.books
                   success()
               case .failure(let error):
                   failure(error)
               }
           }
       }
}
