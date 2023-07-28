//
//  Router.swift
//  CryptoViper
//
//  Created by Doğukan Temizyürek on 27.07.2023.
//

import Foundation
import UIKit
//Class , Protocol
//EntryPoint

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter
{
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter
{
        var entry: EntryPoint?
        static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
            
            var view : AnyView = CryptoViewController()
            var presenter : AnyPresenter = CryptoPresenter()
            var Interactor : AnyInteractor = CryptoInteractor()
            
            view.presenter = presenter
            
            presenter.view = view
            presenter.router = router
            presenter.Interactor = Interactor
            
            Interactor.presenter = presenter
            
            router.entry = view as? EntryPoint
        
        return router
    }
    
    
}
