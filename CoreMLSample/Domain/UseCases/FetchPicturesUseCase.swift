//
//  ImagesUseCase.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum PicturesResult {
    case error(ErrorResponse)
    case success(photos : [Picture])
}

typealias PicturesFetchResult = (PicturesResult) -> Void

final class FetchPicturesUseCase: UseCase {

    private let urlBuilder: URLBuilder
    private let networkingGeteway: NetworkingGeteway
    private let completion: PicturesFetchResult

    init(networkingGeteway: NetworkingGeteway, urlBuilder: URLBuilder ,completion: @escaping PicturesFetchResult) {
        self.networkingGeteway = networkingGeteway
        self.urlBuilder = urlBuilder
        self.completion = completion
    }

    func execute() {
        let url = urlBuilder.queryUrl(with: ["key" : Bundle.main.apiKey, "per_page" : "100", "q" : "travel" ])
        networkingGeteway.get(withType: Hit.self, url: url) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .error(let error):
                self.completion(.error(error))
            case .success(result: let result):
                self.completion(.success(photos: result.hits))
            }
        }
    }
}
