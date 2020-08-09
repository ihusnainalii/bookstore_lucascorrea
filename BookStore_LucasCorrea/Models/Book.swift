//
//  Book.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation

enum SaleAbilityStatus: String, Decodable {
    case forSale = "FOR_SALE"
    case notForSale = "NOT_FOR_SALE"
    case free = "FREE"
}

struct Book: Decodable {
    
    let id: String
    let title: String
    let subtitle: String
    let authors: [String]
    let description: String
    let thumbnail: String
    let saleability: SaleAbilityStatus
    let price: Double?
    let currencyCode: String?
    let buyLink: String?
  
    enum CodingKeys: String, CodingKey {
        case volumeInfo
        case imageLinks
        case saleInfo
        case listPrice
        case id
        case title
        case subtitle
        case authors
        case description
        case thumbnail
        case saleability
        case price = "amount"
        case currencyCode
        case buyLink
    }
    
    init(id: String, title: String, subtitle: String, authors: [String], description: String, thumbnail: String, saleability: SaleAbilityStatus, price: Double?, currencyCode: String?, buyLink: String?) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.description = description
        self.thumbnail = thumbnail
        self.saleability = saleability
        self.price = price
        self.currencyCode = currencyCode
        self.buyLink = buyLink
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let volumeInfo = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)
        
        id = try container.decode(String.self, forKey: .id)
        title = try volumeInfo.decode(String.self, forKey: .title)
        subtitle = try volumeInfo.decodeIfPresent(String.self, forKey: .subtitle) ?? ""
        authors = try volumeInfo.decodeIfPresent([String].self, forKey: .authors) ?? []
        description = try volumeInfo.decodeIfPresent(String.self, forKey: .description) ?? ""
        
        let imageLinks = try? volumeInfo.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)
        thumbnail = try imageLinks?.decodeIfPresent(String.self, forKey: .thumbnail) ?? ""
        
        let saleInfo = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
        saleability = try saleInfo.decode(SaleAbilityStatus.self, forKey: .saleability)
        buyLink = try? saleInfo.decode(String.self, forKey: .buyLink)
        
        let listPrice = try? saleInfo.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
        price = try listPrice?.decode(Double.self, forKey: .price)
        currencyCode = try listPrice?.decode(String.self, forKey: .currencyCode)
    }
    
    func priceNormalize() -> String {
        guard let price = price, let currencyCode = currencyCode else {
            return ""
        }
        let symbol = getSymbol(forCurrencyCode: currencyCode)!
        return "\(symbol)\(String(format: "%.2f", price))"
    }
    
    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }
}
