//
//  Presenter.swift
//  CryptoViper
//
//  Created by Doğukan Temizyürek on 27.07.2023.
//

import Foundation

//Class , protocol
// talks to -> Intrector , router  , view

enum NetworkError : Error
{
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter
{
    var router : AnyRouter?{get set}
    var Interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func InteractorDidDownloadCrypto (result : Result<[Crypto],Error>)
}
class CryptoPresenter : AnyPresenter
{
    var router: AnyRouter?
    
    var Interactor: AnyInteractor?{
        didSet{
            Interactor?.downloadCryptos()
        }
        
    }
    
    
    var view: AnyView?
    
    func InteractorDidDownloadCrypto(result: Result<[Crypto], Error>)
    {
        switch result{
            
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Error...")
            
            
            
            
        }
        
        
    }
}
