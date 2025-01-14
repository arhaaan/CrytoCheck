//
//  HomeViewController.swift
//  CryptoCheck
//
//  Created by Karim Arhan on 14/01/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cryptoArray = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")

        tableView.dataSource = self
        tableView.delegate = self
        
        let urlString = "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json"
        
        WebService().getCrypto(url: URL(string: urlString)!) { result in
            switch result {
            case .success(let cryptos):
                print(cryptos)
                self.cryptoArray = cryptos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.currencyLabel.text = cryptoArray[indexPath.row].currency
        cell.priceLabel.text = cryptoArray[indexPath.row].price
        return cell
    }
    
}
