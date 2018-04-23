//
//  PicturesListConnector.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

protocol ImagesListConnectorDelegate: class {

    func showImageDetailsView(with image: RenderableImage)
}

final class PicturesListConnector {

    //MARK:- Constants

    private unowned let navigationController: UINavigationController
    private let useCaseFactory: UseCaseProvider

    //MARK:- Connector's life cycle

    init(with navigationController: UINavigationController, useCaseFactory: UseCaseProvider) {
        self.navigationController = navigationController
        self.useCaseFactory = useCaseFactory
        showImagesListView()
    }

    //MARK:- Main

    private func showImagesListView() {
        let presenter = PicturesListPresenter(connectorDelegate: self, useCaseFactory: useCaseFactory)
        let listView = PicturesListViewController(presenter: presenter)
        presenter.view = listView
        navigationController.pushViewController(listView, animated: true)
    }
}

//MARK:- ImagesListConnectorDelegate
extension PicturesListConnector: ImagesListConnectorDelegate {

    func showImageDetailsView(with image: RenderableImage) {
        let presenter = PictureDetailsPresenter(connectorDelegate: self, userCaseFactory: useCaseFactory, image: image)
        let detailsView = PictureDetailsViewController(presenter: presenter)
        presenter.view = detailsView
        navigationController.pushViewController(detailsView, animated: true)
    }
}
