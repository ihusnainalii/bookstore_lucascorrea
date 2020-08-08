//
//  BookStoreRouter.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

enum BookStoreRouter: Router {
    case book(query: String, maxResults: String, startIndex: String)
}

//    https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=0

extension BookStoreRouter {
    
    //
    // MARK: - Properties
    var method: String {
        switch self {
            case .book:
                return "GET"
        }
    }

    var host: String {
        switch self {
            case .book:
                return "www.googleapis.com"
        }
    }
    
    var path: String {
        switch self {
            case .book:
                return "/books/v1/volumes"
        }
    }
    
    var headers: [String: String] {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
    
    var scheme: String {
        switch self {
            case .book:
                return "https"
        }
    }
    
    var parameters: [String: String] {
        switch self {
            case .book(let query, let maxResults, let startIndex):
                return [
                    "q": query,
                    "maxResults": maxResults,
                    "startIndex": startIndex
            ]
        }
    }
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        
        switch self {
            case .book:
                urlComponents.scheme = scheme
                urlComponents.host = host
                urlComponents.path = path
                if parameters.count > 0 {
                    urlComponents.setQueryItems(with: parameters)
                }
                return urlComponents
        }
    }
}
