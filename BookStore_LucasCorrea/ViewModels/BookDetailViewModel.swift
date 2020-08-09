//
//  BookDetailViewModel.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 08/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

protocol BookDetailCoordinatorDelegate: AnyObject {
    func didFinish()
}

class BookDetailViewModel {
    
    //
    // MARK: - Properties
    var book: Book?
    weak var coordinator: BookDetailCoordinatorDelegate?
    let bookRepository: Repository
    
    //
    // MARK: - Initializer DI
    init(bookRepository: Repository = CoreDataRepository()) {
        self.bookRepository = bookRepository
    }
    
    //
    // MARK: - Public Functions
    func isFavorite() -> Bool {
        guard let book = book else { return false }
        guard let _ = bookRepository.getBook(id: book.id) else {
            return false
        }
        
        return true
    }
    
    func bookmark(favorite: Bool) {
        if favorite {
            favoriteBook()
        } else {
            unFavoriteBook()
        }
    }
    
    func didFinish() {
        coordinator?.didFinish()
    }
    
    //
    // MARK: - Private Functions
    private func favoriteBook() {
        guard let book = book else { return }
        bookRepository.save(book: book)
    }
    
    private func unFavoriteBook() {
        guard let book = book else { return }
        bookRepository.delete(book: book)
    }
    
}
