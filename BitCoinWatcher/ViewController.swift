//
//  ViewController.swift
//  BitCoinWatcher
//
//  Created by Sebastian Öberg on 2021-02-17.
//

import UIKit

class ViewController: UIViewController {    
    
    let gradientLayer = CAGradientLayer()
    var bitCoinPriceLabel: UILabel!
    var bitCoinPrice: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "BTC price in USD"
        navigationController?.navigationBar.barTintColor = UIColor.gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(makeRequest))
                
        makeRequest()
    }
    
    override func loadView() {
        view = UIView()
        
        gradientLayer.colors = [UIColor.systemYellow.cgColor,UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.layoutMargins = UIEdgeInsets(top: 96, left: 64, bottom: 0, right: 64)
        
        bitCoinPriceLabel = UILabel()
        bitCoinPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        bitCoinPriceLabel.font = UIFont(name: "Thonburi", size: 40)
        bitCoinPriceLabel.minimumScaleFactor = 0.5
        bitCoinPriceLabel.textAlignment = .center
        bitCoinPriceLabel.textColor = .black
        view.addSubview(bitCoinPriceLabel)
        
        NSLayoutConstraint.activate([
            bitCoinPriceLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            bitCoinPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = view.bounds
    }
    
    @objc func makeRequest() {
        let coinBaseUrl =  "https://api.coinbase.com/v2/prices/spot?currency=USD"

        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: coinBaseUrl) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    return
                }
            }
            self.showError()
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonReponse = try? decoder.decode(BitCoinResponse.self, from: json) {
            DispatchQueue.main.async {
                self.bitCoinPriceLabel.text = "$ \(jsonReponse.data.amount)"
            }
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}
