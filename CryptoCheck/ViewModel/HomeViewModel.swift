//
//  HomeViewModel.swift
//  CryptoCheck
//
//  Created by Karim Arhan on 14/01/25.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    var cryptos : PublishSubject<[Crypto]> = PublishSubject()
    var error : PublishSubject<String> = PublishSubject()
    var loading : PublishSubject<Bool> = PublishSubject()
    
    func requestData() {
        self.loading.onNext(true)
        let urlString = "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json"
        
        WebService().getCrypto(url: URL(string: urlString)!) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
                
            case .failure(let error):
                switch error {
                case .serverError:
                    self.error.onNext("Server Error")
                case .parsingError:
                    self.error.onNext("Parsing Error")
                }
            }
        }
    }
}
