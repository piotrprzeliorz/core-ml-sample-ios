//
//  PicturesListViewController.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 14.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

final class PicturesListViewController: BaseViewController<PicturesListPresenter>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PicturesListScene {

    //MARK:- IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView!

    //MARK:- VC's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollecionView()
        presenter.getImages()
    }

    //MARK:- Main

    private func setupView() {
        navigationItem.title = "CoreMLSample"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func setupCollecionView() {
        collectionView.register(PictureCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    //MARK:- PicturesListScene

    func reload() {
        collectionView.reloadData()
    }

    func showeAlert(with error: ErrorResponse) {
        showErrorAlert(with: error) { _ in
            self.presenter.getImages()
        }
    }

    //MARK:- UICollectionViewDelegate, UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PictureCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(with: presenter.images[indexPath.row].previewURL)
        return cell 
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showImageDetailsView(for: indexPath)
    }

    //MARK:- UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(2))
        return CGSize(width: size, height: size)
    }
}
