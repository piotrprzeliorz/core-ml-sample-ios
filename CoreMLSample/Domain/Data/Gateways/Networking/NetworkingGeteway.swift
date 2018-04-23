//
//  NetworkingGeteway.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

typealias ResultBlock<ResponseModel> = (Result<ResponseModel>) -> ()

enum Result<ResponseModel> {
    case error(ErrorResponse)
    case success(result : ResponseModel)
}

protocol NetworkingGeteway {

    init(urlSessionConfiguration: URLSessionConfiguration, decoder: JSONDecoder)

    @discardableResult
    func get<ResponseModel: Decodable>(withType type: ResponseModel.Type, url: URL, completion: @escaping (ResultBlock<ResponseModel>)) -> URLSessionTask
}

