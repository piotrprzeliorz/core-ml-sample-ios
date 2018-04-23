//
//  Bundle.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

extension Bundle {

    var apiKey: String {
        get {
            guard let value = self.infoDictionary?["API_KEY"] as? String else { fatalError("No key API_KEY in plist") }
            return value
        }
    }

    var apiEndpoint: String {
        get {
            guard let item = self.infoDictionary?["API_ENDPOINT"] as? String else { fatalError("No key API_ENDPOINT in plist") }
            return item
        }
    }
}
