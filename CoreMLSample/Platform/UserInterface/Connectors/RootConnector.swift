//
//  RootConnector.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

protocol RootConnectorDelegate: class {

    func startImageListConnector()
}

final class RootConnector {

    //MARK:- Constnats

    private let window: UIWindow
    private let navigationController: UINavigationController

    //MARK:- Variables

    private var picturesListConnector: PicturesListConnector?

    init(with window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window.backgroundColor = .white
        self.window.rootViewController = navigationController
        showSplashScreen()
    }

    private func showSplashScreen() {
        let presenter = SplashScreenPresnter(connectorDelegate: self)
        let splashView = SplashScreenViewController(presenter: presenter)
        navigationController.pushViewController(splashView, animated: true)
    }
}

//MARK:- RootConnectorDelegate
extension RootConnector: RootConnectorDelegate {

    func startImageListConnector() {
        navigationController.viewControllers.removeAll()
        let geteway = APIClient(urlSessionConfiguration: URLSessionConfiguration.default, decoder: JSONDecoder())
        let urlBuilder = URLProvider(apiURL: Bundle.main.apiEndpoint)
        let mlModel = RN1015k500()
        let useCaseFactory = UseCaseFactory(networkingGeteway: geteway, urlBuilder: urlBuilder, mlModel: mlModel)
        picturesListConnector = PicturesListConnector(with: navigationController, useCaseFactory: useCaseFactory)
    }
}
