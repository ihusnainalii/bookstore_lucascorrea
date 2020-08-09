//
//  BookStoreViewModel.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

typealias SuccessBookStoreHandler = ([IndexPath]) -> Void

protocol BookStoreCoordinatorDelegate: AnyObject {
    func showBookDetail(viewModel: BookDetailViewModel)
}

class BookStoreViewModel {
    
    //
    // MARK: - Properties
    var bookItems: [Book]
    var service: BookStoreService
    var totalItems: Int
    weak var coordinator: BookStoreCoordinatorDelegate?
    
    //
    // MARK: - Initializer DI
    init(service: BookStoreService = BookStoreService(client: BookStoreClient())) {
        self.service = service
        self.bookItems = [Book]()
        self.totalItems = 0
    }
    
    //
    // MARK: - Public Functions
    
    /// BookStore list
    /// - Parameters:
    ///   - success: Closure IndexPaths
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
                    self.totalItems = bookStoreContainer.totalItems
                    
                    success(newIndexPaths)
                case .failure(let error):
                    failure(error)
            }
        }
    }
    
    /// Show detail of a book
    /// - Parameter book: Book
    func showDetail(of book: Book) {
        let bookDetail = BookDetailViewModel()
        bookDetail.book = book
        coordinator?.showBookDetail(viewModel: bookDetail)
    }
}
