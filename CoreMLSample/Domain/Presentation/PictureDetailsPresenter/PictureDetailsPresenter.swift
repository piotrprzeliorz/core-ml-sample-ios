//
//  PictureDetailsPresenter.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation
import CoreGraphics

final class PictureDetailsPresenter: BasePresenter {

    //MARK:- Variables

    weak var view: PictureDetailsScene?

    private weak var connectorDelegate: ImagesListConnectorDelegate?
    private var useCase: RecognizeImageUseCase?

    //MARK:- Constants

    private let userCaseFactory: UseCaseProvider
    private let image: RenderableImage

    // MARK:- Presneter's life cycle

    init(connectorDelegate: ImagesListConnectorDelegate?, userCaseFactory: UseCaseProvider, image: RenderableImage) {
        self.userCaseFactory = userCaseFactory
        self.connectorDelegate = connectorDelegate
        self.image = image
    }

    //MARK:- Main

    func processImage(with picture: CGImage) {
        useCase = userCaseFactory.getRecognizeUseCase(picture: picture) { [weak self] imageRecognationResult in
            guard let `view` = self?.view else { return }
            view.setPlace(with: imageRecognationResult.latitude, longitude: imageRecognationResult.longitude)
            view.setConfidence(with: imageRecognationResult.confidence)
        }
        useCase?.execute()
    }

    func getImageURL() -> URL {
        return image.largeImageURL
    }
}
