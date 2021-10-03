//
//  ViewController.swift
//  StockTracker
//
//  Created by Pavel Ryabov on 11.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
     var filteredStocks = [Stock]()
     let searchController = UISearchController(searchResultsController: nil)
    
     var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else{return false}
        return text.isEmpty
    }
    
     var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //networkManager.fetchStockData()
        fetchStockData()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find ticker"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    

    
    // MARK: - Network
    let tickers = ["AAPL","MSFT","AMZN","FB","TSLA"]
    var stocks = [Stock]()
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
    
    //MARK: - Navigation
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChart" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! ChartViewController
                if isFiltering {
                    dvc.openPrice.append(filteredStocks[indexPath.row].openPriceDouble)
                    dvc.highPrice.append(filteredStocks[indexPath.row].highPriceDouble)
                    dvc.lowPrice.append(filteredStocks[indexPath.row].lowPriceDouble)
                    dvc.chartTickerText.append(filteredStocks[indexPath.row].symbol)
                } else {
                    dvc.openPrice.append(stocks[indexPath.row].openPriceDouble)
                    dvc.highPrice.append(stocks[indexPath.row].highPriceDouble)
                    dvc.lowPrice.append(stocks[indexPath.row].lowPriceDouble)
                    dvc.chartTickerText.append(stocks[indexPath.row].symbol)
                }
            }
        }
    }
}


//MARK: - Search Controller
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text!)
    }
    
     func filteredContentForSearchText (_ searchText: String) {
        filteredStocks = stocks.filter ( { (stock: Stock) -> Bool in
            return stock.symbol.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
//MARK: - TableView Data Source Methods 
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredStocks.count
        }
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        var stock: Stock
        if isFiltering {
            stock = filteredStocks[indexPath.row]
        } else {
            stock = stocks[indexPath.row]
        }
        cell.tickerLabel.text = stock.symbol
        cell.priceLabel.text = "$" + String(format: "%.2f", stock.priceDouble)
        cell.percentChangeLabel.text = "(" + stock.percentChange + ")"
        cell.priceChangeLabel.text = String(format: "%.2f", stock.priceChangeDouble)
        cell.favoriteButton.tintColor = .gray
        return cell
    }
}






