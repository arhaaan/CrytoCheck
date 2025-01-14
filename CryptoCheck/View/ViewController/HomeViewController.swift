//
//  HomeViewController.swift
//  CryptoCheck
//
//  Created by Karim Arhan on 14/01/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    let homeVM = HomeViewModel()
    let disposeBag = DisposeBag()
    
    var cryptoArray = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        setupBindings()
        homeVM.requestData()
    }
    
    private func setupBindings() {
        homeVM.loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        homeVM.error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        
//        homeVM
//            .cryptos
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe { cryptos in
//                self.cryptoArray = cryptos
//                self.tableView.reloadData()
//            }
//            .disposed(by: disposeBag)
        
        homeVM.cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "HomeTableViewCell", cellType: HomeTableViewCell.self)) {row,item,cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
    }

}
