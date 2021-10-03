//
//  Stock.swift
//  StockTracker
//
//  Created by Pavel Ryabov on 27.03.2021.
//

import Foundation

struct Stock {
    let symbol: String
    
    let price: String
    var priceDouble: Double {
      return Double(price)!
    }
    
    
    let priceChange: String
    var priceChangeDouble: Double {
        return Double(priceChange)!
    }
    
    let percentChange: String
    
    let openPrice: String
    
    var openPriceDouble: Double {
        return Double(openPrice)!
    }
    let highPrice: String
    var highPriceDouble: Double {
        return Double(highPrice)!
    }
    
    let lowPrice: String
    var lowPriceDouble: Double {
        return Double(lowPrice)!
    }
    
    init?(stockData: StockData) {
        symbol = stockData.globalQuote.the01Symbol
        price = stockData.globalQuote.the05Price
        priceChange = stockData.globalQuote.the09Change
        percentChange = stockData.globalQuote.the10ChangePercent
        openPrice = stockData.globalQuote.the02Open
        highPrice = stockData.globalQuote.the03High
        lowPrice = stockData.globalQuote.the04Low
    }
}
