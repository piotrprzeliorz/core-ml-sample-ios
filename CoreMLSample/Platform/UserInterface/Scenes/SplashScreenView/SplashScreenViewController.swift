//
//  SplashScreenViewController.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

final class SplashScreenViewController: BaseViewController<SplashScreenPresnter> {

    //MARK:- IBOutlets

    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!

    //MARK:- Variables

    private lazy var yScale = logoImageView.frame.height / containerView.frame.height
    private lazy var xScale = logoImageView.frame.width / containerView.frame.width

    //MARK:- VC's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startAnimation()
    }

    //MARK:- Main

    private func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func startAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
             self.containerView.transform = CGAffineTransform(scaleX: 1, y: self.yScale)
        }, completion: { _ in
            self.transformConatainerYAxis()
        })
    }

    private func transformConatainerYAxis() {
        UIView.animate(withDuration: 0.3, animations: {
             self.containerView.transform = CGAffineTransform(scaleX: self.xScale, y: self.yScale)
        }, completion: { _ in
            self.transormLogoImageView()
        })
    }

    private func transormLogoImageView() {
        UIView.animate(withDuration: 0.1, delay: 0.2, options: [], animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.0001, y: self.yScale)
            self.logoImageView.transform = CGAffineTransform(scaleX: 0.0001, y: 1)
            self.containerView.alpha = 0
        }, completion: { _ in
            self.presenter.animationFinished()
        })
    }
}

