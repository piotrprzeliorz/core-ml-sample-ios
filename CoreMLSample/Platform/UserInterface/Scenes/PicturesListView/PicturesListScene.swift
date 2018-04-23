//
//  PicturesListScene.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

protocol PicturesListScene: class {

    func reload()
    func showeAlert(with error: ErrorResponse)

}
