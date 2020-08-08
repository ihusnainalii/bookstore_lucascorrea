//
//  NetworkClient.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

protocol NetworkClientCancelling {
    func cancelRequest()
}

protocol NetworkClientRequesting {
    mutating func request<T: Decodable>(router: Router, returnType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

protocol NetworkClient: NetworkClientRequesting {
    
}
