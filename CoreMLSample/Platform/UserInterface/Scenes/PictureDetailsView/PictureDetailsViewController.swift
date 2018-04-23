//
//  PictureDetailsViewController.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

final class PictureDetailsViewController: BaseViewController<PictureDetailsPresenter>, PictureDetailsScene {

    //MARK:- IBOutlets

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var mapView: MKMapView!

    //MARK:- Variables

    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray, placeInTheCenterOf: imageView)

    //MARK:- VC's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getImageURL()
    }

    //MARK:- Main

    private func getImageURL() {
        activityIndicator.startAnimating()
        let url = presenter.getImageURL()
        imageView.loadImage(with: url) { [weak self] (image) in
            guard let `image` = image else { return }
            guard let `self` = self else { return }
            guard let cgImage = image.cgImage else { return }
            self.presenter.processImage(with: cgImage)
            self.activityIndicator.stopAnimating()
        }
    }

    //MARK:- PictureDetailsScene
    
    func setPlace(with latitude: Double, longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        mapView.addAnnotation(annotation)
        mapView.setCenter(annotation.coordinate, animated: true)
    }

    func setConfidence(with value: Double) {
        navigationItem.title = "Confidence: \(value.percentageValue)%"
    }
}
