//
//  HomeViewController.swift
//  CryptoCheck
//
//  Created by Karim Arhan on 14/01/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let homeVM = HomeViewModel()
    let disposeBag = DisposeBag()
    
    var cryptoArray = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")

        tableView.dataSource = self
        tableView.delegate = self
        
        setupBindings()
        homeVM.requestData()
    }
    
    private func setupBindings() {
        homeVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        
        homeVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoArray = cryptos
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
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
