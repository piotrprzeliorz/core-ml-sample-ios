//
//  PicturesListPresenter.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

final class PicturesListPresenter: BasePresenter {

    //MARK:- Variables

    private weak var connectorDelegate: ImagesListConnectorDelegate?
    private(set) var images: [RenderableImage] = []
    private var useCase: FetchPicturesUseCase?
    var view: PicturesListScene?

    //MARK:- Constnats

    private let useCaseFactory: UseCaseProvider

    // MARK:- Presneter's life cycle

    init(connectorDelegate: ImagesListConnectorDelegate?, useCaseFactory: UseCaseProvider) {
        self.connectorDelegate = connectorDelegate
        self.useCaseFactory = useCaseFactory
    }

    //MARK:- Main

    func getImages() {
        useCase = useCaseFactory.getPicturesProviderUseCase { [weak self] result in
            guard let `self` = self else { return }
            guard let `view` = self.view else { return }
            switch result {
            case .error(let error):
                view.showeAlert(with: error)
            case .success(photos: let images):
                self.images = images
                view.reload()
            }
        }
        useCase?.execute()
    }

    func showImageDetailsView(`for` indexPath: IndexPath) {
        let image = images[indexPath.item]
        connectorDelegate?.showImageDetailsView(with: image)
    }
}
