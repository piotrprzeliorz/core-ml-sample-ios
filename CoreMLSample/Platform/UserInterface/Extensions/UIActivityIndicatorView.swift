//
//  UIActivityIndicatorView.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 19.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {

    convenience init(activityIndicatorStyle: UIActivityIndicatorViewStyle, placeInTheCenterOf parentView: UIView) {
        self.init(activityIndicatorStyle: activityIndicatorStyle)
        center = parentView.center
        hidesWhenStopped = true
        parentView.addSubview(self)
    }
}
