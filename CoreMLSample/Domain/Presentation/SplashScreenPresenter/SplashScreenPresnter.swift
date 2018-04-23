//
//  SplashScreenPresnter.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

final class SplashScreenPresnter: BasePresenter {

    //MARK:- Variables

    private weak var rootConnectorDelegate: RootConnectorDelegate?

    // MARK:- Presneter's life cycle

    init(connectorDelegate: RootConnectorDelegate?) {
        rootConnectorDelegate = connectorDelegate
    }

    //MARK:- Main

    func animationFinished() {
        rootConnectorDelegate?.startImageListConnector()
    }
}
