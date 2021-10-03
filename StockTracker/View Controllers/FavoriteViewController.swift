//
//  FavoriteViewController.swift
//  StockTracker
//
//  Created by Pavel Ryabov on 15.03.2021.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let shared = FavoriteViewController()
    @IBOutlet var favoriteTableView: UITableView!
    @IBAction func goBackButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToVC", sender: self)
    }
    
    let defaults = UserDefaults.standard
    var favoriteList: [StockData] {
        get {
            if let data = defaults.value(forKey: "stocks") as? Data {
                return try! PropertyListDecoder().decode([StockData].self, from: data)
            } else {
                return [StockData]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "stocks")
            }
        }
        
    }
    
    func saveToFavoriteList (ticker: String, price: String, priceChange: String, percentChange: String) {
        let favoriteStocks = StockData(globalQuote: .init(the05Price: price, the09Change: priceChange, the10ChangePercent: percentChange, the01Symbol: ticker, the02Open: "", the03High: "", the04Low: ""))
        favoriteList.append(favoriteStocks)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! CustomFavoriteTableViewCell
        let favoriteStock = favoriteList[indexPath.row]
        cell.favoriteButton2.tintColor = .orange
        cell.favoriteTickerLabel.text = favoriteStock.globalQuote.the01Symbol
        cell.favoritePriceLabel.text = favoriteStock.globalQuote.the05Price
        cell.favoritePriceChangeLabel.text = favoriteStock.globalQuote.the09Change
        cell.favoritePercentChangeLabel.text = favoriteStock.globalQuote.the10ChangePercent
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
