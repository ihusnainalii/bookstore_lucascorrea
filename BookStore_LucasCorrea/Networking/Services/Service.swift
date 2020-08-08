//
//  Service.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

typealias SuccessHandler = () -> Void
typealias FailureHandler = (NetworkError) -> Void

protocol Service {
    init(client: NetworkClient)
}
