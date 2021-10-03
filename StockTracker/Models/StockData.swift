//
//  StockData.swift
//  StockTracker
//
//  Created by Pavel Ryabov on 16.03.2021.
//

import Foundation

struct StockData: Codable {
    let globalQuote: GlobalQuote
    enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    }
}
struct GlobalQuote: Codable {
    let the05Price: String
    let the09Change: String
    let the10ChangePercent: String
    let the01Symbol: String
    let the02Open: String
    let the03High: String
   let the04Low: String
    
    enum CodingKeys: String, CodingKey {
        case the05Price = "05. price"
        case the09Change = "09. change"
        case the10ChangePercent = "10. change percent"
        case the01Symbol = "01. symbol"
        case the02Open = "02. open"
        case the03High = "03. high"
        case the04Low = "04. low"
    }
    
}

