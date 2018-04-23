//
//  UIImageView.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import Kingfisher

extension UIImageView {

    @discardableResult
    func loadImage(with url: URL, completionHandler: @escaping (UIImage?) -> ()) -> FetchImageTask {
        let task = kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            completionHandler(image)
        }
        return task
    }
}

protocol FetchImageTask {
    func cancel()
}

extension RetrieveImageTask: FetchImageTask { }


