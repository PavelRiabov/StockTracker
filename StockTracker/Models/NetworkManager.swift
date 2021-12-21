//
//  NetworkManager.swift
//  StockTracker
//
//  Created by Pavel Ryabov on 17.12.2021.
//

import Foundation


extension ViewController {
    // MARK: - Network

    func fetchStockData() {
        for ticker in tickers {
            let urlString = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(ticker)&apikey=\(apiKey)"
            guard let url = URL(string: urlString) else {return}
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let _ = self.parseJSON(withData: data)
                }
            }
            task.resume()
        }
    }

    func parseJSON (withData data: Data) -> Stock? {
        let decoder = JSONDecoder()
        do {
            let stockData = try decoder.decode(StockData.self, from: data)
            guard let stocks = Stock(stockData: stockData) else {
                return nil
            }
            DispatchQueue.main.async {
                self.stocks.append(stocks)
                self.tableView.reloadData()
            }
            return stocks

        } catch let error as NSError {
            print(error)

        }
        return nil
    }
}


