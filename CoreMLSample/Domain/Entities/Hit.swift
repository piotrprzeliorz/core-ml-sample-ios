//
//  Hit.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Hit: Decodable {
    
    let hits: [Picture]
    let totalHits: Int
}
