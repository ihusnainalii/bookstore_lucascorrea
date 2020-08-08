//
//  NetworkError.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case statusCodeError(message: String, code: Int)
    case domainError
    case decodingError(message: String)
    case unknownError
}

extension NetworkError: LocalizedError {
    
    //
    // MARK: - Properties
    public var errorDescription: String? {
        
        switch self {
            case .invalidURL:
                return NSLocalizedString("URL error", comment: "Invalid url")
            case .statusCodeError(let message, let code):
                return NSLocalizedString("GET/POST request not successful. \(code) \(message)", comment: "NetworkError")
            case .domainError:
                return NSLocalizedString("Domain error", comment: "NetworkError")
            case .decodingError(let message):
                return NSLocalizedString("Decoding error. \(message)", comment: "NetworkError")
            case .unknownError:
                return NSLocalizedString("Unknown error", comment: "NetworkError")
        }
        
    }
}
