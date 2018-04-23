//
//  URLBuilder.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

typealias Parameters = [String : String]

protocol URLBuilder {

    init(apiURL: String)
    func queryUrl(with parameters: Parameters) -> URL 
}

struct URLProvider: URLBuilder {

    private let base: String

    init(apiURL: String) {
        self.base = apiURL
    }

    func queryUrl(with parameters: Parameters) -> URL {
        let queryComponents = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        var urlComps = URLComponents(string: base)!
        urlComps.queryItems = queryComponents
        return urlComps.url!
    }
}
