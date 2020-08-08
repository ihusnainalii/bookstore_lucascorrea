//
//  Router.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

protocol Router {
    var method: String { get }
    var path: String { get }
    var scheme: String { get }
    var host: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
    var urlComponents: URLComponents { get }
}
