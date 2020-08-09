//
//  BookStoreContainer.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

struct BookStoreContainer: Decodable {
    let kind: String
    let totalItems: Int
    let books: [Book]
    
    enum CodingKeys: String, CodingKey {
        case kind
        case totalItems
        case books = "items"
    }
}
