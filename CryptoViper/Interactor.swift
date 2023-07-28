//
//  Interactor.swift
//  CryptoViper
//
//  Created by Doğukan Temizyürek on 27.07.2023.
//

import Foundation

protocol AnyInteractor
{
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
    
}

class CryptoInteractor : AnyInteractor
{
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        else
        {
          return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil
            else
            {
                self.presenter?.InteractorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self.presenter?.InteractorDidDownloadCrypto(result: .success(cryptos))
                
            }catch{
                self.presenter?.InteractorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
                
            }
        }
        task.resume()
    }
    
    
}
