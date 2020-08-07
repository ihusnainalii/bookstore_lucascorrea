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
    var bookItems: [String]
    
    //
    // MARK: - Initializer DI
    init() {
        self.bookItems = [String]()
    }
}
