//
//  Picture.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Foundation

protocol RenderableImage {

    var previewURL: URL { get }
    var largeImageURL: URL { get }
}

struct Picture: RenderableImage, Decodable {

    let previewURL: URL
    let largeImageURL: URL
    let id: Int

}
