//
//  BookStoreClient.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

struct BookStoreClient: NetworkClient, NetworkClientCancelling {
    
    //
    // MARK: - Properties
    var session: URLSession
    var dataTask: URLSessionDataTask?
    
    /// Init
    /// - Parameter urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.session = urlSession
    }
    
    //
    // MARK: - Public Functions
    
    /// This method is responsible for requesting with the API.
    /// - Parameters:
    ///   - router: Router contains which method, path, headers, parameters and url will be used in the request.
    ///   - returnType: Which is the type of model returned in the result.
    ///   - completion: Result<Type of model, NetworkError>
    mutating func request<T>(router: Router, returnType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        guard let url = router.urlComponents.url else {
            return completion(.failure(.invalidURL))
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: Config.timeout)
        urlRequest.httpMethod = router.method
        
        for (key, value) in router.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(.failure(.domainError))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse {
                // 200 OK, 201 Created, 202 Accepted, 204 No content (PUT, POST or DELETE)
                if (200...204).contains(response.statusCode) {
                    do {
                        let object = try JSONDecoder().decode(returnType, from: data)
                        completion(.success(object))
                    } catch {
                        completion(.failure(.decodingError(message: error.localizedDescription)))
                    }
                } else {
                    completion(.failure(.statusCodeError(message: "Unexpected statusCode", code: response.statusCode)))
                }
            }
        }
        
        dataTask?.resume()
    }
    
    func cancelRequest() {
        dataTask?.cancel()
    }
}
