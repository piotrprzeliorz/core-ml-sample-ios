//
//  ImageCell.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

final class PictureCell: UICollectionViewCell {

    //MARK:- IBOutlets

    @IBOutlet private weak var imageView: UIImageView!

    //MARK:- Variables

    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray, placeInTheCenterOf: imageView)
    private var task: FetchImageTask?

    //MARKL:- Cell's life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFit
        task = nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        activityIndicator.stopAnimating()
    }

    //MARK:- Main

    func setup(with url: URL) {
        activityIndicator.startAnimating()
        task = imageView.loadImage(with: url, completionHandler: { [weak self] _ in
            guard let `self` = self else { return }
            self.activityIndicator.stopAnimating()
        })
    }
}


