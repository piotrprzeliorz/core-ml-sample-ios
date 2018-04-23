//
//  APIClient.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

final class APIClient: NetworkingGeteway {

    //MARK:- Constants

    private let session: URLSession
    private let decoder: JSONDecoder

    init(urlSessionConfiguration: URLSessionConfiguration, decoder: JSONDecoder) {
        self.session = URLSession(configuration: urlSessionConfiguration)
        self.decoder = decoder
    }

    //MARK:- Open methods

    func get<ResponseModel: Decodable>(withType type: ResponseModel.Type, url: URL, completion: @escaping (ResultBlock<ResponseModel>)) -> URLSessionTask {
        let request = configuration(forURL: url, httpMethod: .get)
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            self.processResponse(type: ResponseModel.self, data: data, response: response, error: error, processedResponse: { (value) in
                DispatchQueue.main.async {
                    completion(value)
                }
            })
        }
        task.resume()
        return task
    }

    //MARK:- Private methods

    private func processResponse<ResponseModel: Decodable>(type: ResponseModel.Type, data: Data?, response: URLResponse?, error: Error?, processedResponse: @escaping (ResultBlock<ResponseModel>))  {
        if let error = error  {
            switch error {
            case (let error as NSError) where error.code == NSURLErrorNotConnectedToInternet:
                return processedResponse(.error(ErrorResponse(type: ErrorType.noInternetConnection)))
            default:
                return processedResponse(.error(ErrorResponse(type: ErrorType.unexpected)))
            }
        }
        guard let data =  data, let httpResponse = response as? HTTPURLResponse else {
            return processedResponse(.error(ErrorResponse(type: .unexpected)))
        }
        guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
            let message = String(data: data, encoding: .utf8) 
            return processedResponse(.error((ErrorResponse(message: message))))
        }
        do {
            let result = try self.decoder.decode(ResponseModel.self, from: data)
            return processedResponse(Result.success(result: result))
        }
        catch {
            return processedResponse(.error((ErrorResponse(type: .unexpected))))
        }
    }

    private func configuration(forURL url: URL, httpMethod: HTTPMethod, parameters: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        guard let body = parameters else { return request }
        request.httpBody = body
        return request
    }
}
