//
//  Float.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 11.04.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

extension Double {

    var percentageValue: String {
        return String(format: "%.2f", self * 100)
    }
}
