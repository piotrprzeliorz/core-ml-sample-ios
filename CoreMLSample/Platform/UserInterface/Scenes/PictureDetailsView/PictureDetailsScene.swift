//
//  PictureDetailsScene.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 16.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

protocol PictureDetailsScene: class {

    func setPlace(with latitude: Double, longitude: Double)
    func setConfidence(with value: Double)
}
