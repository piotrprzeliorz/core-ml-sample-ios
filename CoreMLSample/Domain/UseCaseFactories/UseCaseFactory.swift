//
//  UseCaseFactory.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation
import CoreGraphics

protocol UseCaseProvider {

    func getPicturesProviderUseCase(completion: @escaping PicturesFetchResult) -> FetchPicturesUseCase
    func getRecognizeUseCase(picture: CGImage, completion: @escaping ImageRecognitionResult) -> RecognizeImageUseCase
}

final class UseCaseFactory: UseCaseProvider {

    private let networkingGeteway: NetworkingGeteway
    private let urlBuilder: URLBuilder
    private let mlModel: RN1015k500

    init(networkingGeteway: NetworkingGeteway, urlBuilder: URLBuilder, mlModel: RN1015k500) {
        self.networkingGeteway = networkingGeteway
        self.urlBuilder = urlBuilder
        self.mlModel = mlModel
    }

    func getPicturesProviderUseCase(completion: @escaping PicturesFetchResult) -> FetchPicturesUseCase {
        return FetchPicturesUseCase(networkingGeteway: networkingGeteway, urlBuilder: urlBuilder, completion: completion)
    }

    func getRecognizeUseCase(picture: CGImage, completion: @escaping ImageRecognitionResult) -> RecognizeImageUseCase {
        return RecognizeImageUseCase(picture: picture, mlModel: mlModel, completion: completion)
    }
}
