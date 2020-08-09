//
//  Repository.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 09/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

protocol Repository {
    @discardableResult
    func save(book: Book) -> Bool
    
    @discardableResult
    func delete(book: Book) -> Bool
    
    func getBook(id: String) -> Book?
    func getAll() -> [Book]
}
