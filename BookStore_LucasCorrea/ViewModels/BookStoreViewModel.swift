//
//  BookStoreViewModel.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

typealias SuccessBookStoreHandler = ([IndexPath]) -> Void

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
    func bookStoreList(search: String, maxResults: String, startIndex: String, success: @escaping SuccessBookStoreHandler, failure: @escaping FailureHandler) {
        self.service.bookList(search: search, maxResults: maxResults, startIndex: startIndex) { result in
            switch result {
                case .success(let bookStoreContainer):
                    
                    let bookStartIndex = self.bookItems.count
                    let bookEndIndex = bookStartIndex + bookStoreContainer.books.count - 1
                    let newIndexPaths = (bookStartIndex...bookEndIndex).map { i in
                        return IndexPath(row: i, section: 0)
                    }
                    
                    self.bookItems += bookStoreContainer.books
                    
                    success(newIndexPaths)
                case .failure(let error):
                    failure(error)
            }
        }
    }
}
