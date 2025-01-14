//
//  WebService.swift
//  CryptoCheck
//
//  Created by Karim Arhan on 14/01/25.
//

import Foundation

enum ErrorResults : Error {
    case serverError
    case parsingError
}

class WebService {
    func getCrypto(url: URL, completion: @escaping (Result<[Crypto],ErrorResults>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(Result.failure(.serverError))
            } else if let data = data {
               let cryptoArray = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoArray = cryptoArray {
                    completion(.success(cryptoArray))
                } else {
                    completion(.failure(.parsingError))
                }
            }
            
        }
        .resume()
    }
}
