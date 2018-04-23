//
//  BaseViewController.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

class BaseViewController<Presenter>: UIViewController where Presenter: BasePresenter {

    let presenter: Presenter

    init(presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("Deinit of \(type(of: self))")
    }

    func showErrorAlert(with error : Error, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Error occurred" , message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
