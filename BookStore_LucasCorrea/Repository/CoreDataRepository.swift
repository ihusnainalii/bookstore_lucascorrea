//
//  CoreDataRepository.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 09/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

class CoreDataRepository: Repository {
    
    //
    // MARK: - Properties
    let coreDataManager: CoreDataManager
    
    //
    // MARK: - Initializer DI
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    //
    // MARK: - Public Functions
    func save(book: Book) -> Bool {
        let bookStore = coreDataManager.add(BookStore.self)
        bookStore?.id = book.id
        bookStore?.title = book.title
        bookStore?.subtitle = book.subtitle
        bookStore?.authors = book.authors.joined(separator: ", ")
        bookStore?.descriptionBook = book.description
        bookStore?.thumbnail = book.thumbnail
        bookStore?.saleability = book.saleability.rawValue
        bookStore?.price = book.price ?? 0
        bookStore?.currencyCode = book.currencyCode
        bookStore?.buyLink = book.buyLink
        
        return coreDataManager.save()
    }
    
    func delete(book: Book) -> Bool {
        let predicate = NSPredicate(format: "id = %@", book.id)
        coreDataManager.delete(BookStore.self, predicate: predicate)
        return true
    }
    
    func getBook(id: String) -> Book? {
        let predicate = NSPredicate(format: "id = %@", id)
        let bookStores = coreDataManager.fetch(BookStore.self, predicate: predicate)
        
        let book = bookStores?.first.map { convertToBook(from: $0) }
        return book
    }
    
    func getAll() -> [Book] {
        guard let booksFavorite = coreDataManager.fetch(BookStore.self) else {
            return [Book]()
        }
        
        return booksFavorite.map { convertToBook(from: $0) }
    }
    
    //
    // MARK: - Private Functions
    private func convertToBook(from bookStore: BookStore) -> Book {
        return Book(id: bookStore.id!,
                    title: bookStore.title!,
                    subtitle: bookStore.subtitle!,
                    authors: bookStore.authors!.components(separatedBy: ", "),
                    description: bookStore.descriptionBook!,
                    thumbnail: bookStore.thumbnail!,
                    saleability: SaleAbilityStatus(rawValue: bookStore.saleability!)!,
                    price: bookStore.price,
                    currencyCode: bookStore.currencyCode,
                    buyLink: bookStore.buyLink)
    }
    
}
