//
//  CustomTableViewCell.swift
//  StockTracker
//
//  Created by Pavel Ryabov on 11.03.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    let defaults = UserDefaults.standard
    @IBOutlet var tickerLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var priceChangeLabel: UILabel!
    @IBOutlet var percentChangeLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    @IBAction func addToFavoriteButtonPressed(_ sender: Any) {
        favoriteButton.tintColor = .orange
        let ticker = tickerLabel.text!
        let price = priceLabel.text!
        let priceChange = priceChangeLabel.text!
        let percentChange = percentChangeLabel.text!
        
        if !ticker.isEmpty && !price.isEmpty && !priceChange.isEmpty && !percentChange.isEmpty {
            FavoriteViewController.shared.saveToFavoriteList(ticker: ticker, price: price, priceChange: priceChange, percentChange: percentChange)
        }
    }
}
