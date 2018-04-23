//
//  ErrorResponse.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum ErrorType {
    case unexpected
    case noInternetConnection
}

struct ErrorResponse: Error {

    let type: ErrorType
    let message: String?

    init(type : ErrorType) {
        self.type = type
        self.message = nil
    }

    init(message: String?) {
        self.message = message
        self.type = .unexpected
    }
}

//MARK:- LocalizedError
extension ErrorResponse: LocalizedError {

    public var errorDescription: String? {
        switch self.type {
        case .unexpected:
            return "Unexpected error"
        case .noInternetConnection:
            return "No intenret connection"
        }
    }
}
