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
    
    //
    // MARK: - Public Functions
    func isFavorite() -> Bool {
        guard let book = book else { return false }
        let predicate = NSPredicate(format: "id = %@", book.id)
        let books = CoreDataManager.shared.fetch(BookStore.self, predicate: predicate)
        
        return books?.count ?? 0 > 0 
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
        let bookStore = CoreDataManager.shared.add(BookStore.self)
        bookStore?.id = book.id
        bookStore?.title = book.title
        CoreDataManager.shared.save()
    }
    
    private func unFavoriteBook() {
        guard let book = book else { return }
        let predicate = NSPredicate(format: "id = %@", book.id)
        CoreDataManager.shared.delete(BookStore.self, predicate: predicate, nil)
    }
}
