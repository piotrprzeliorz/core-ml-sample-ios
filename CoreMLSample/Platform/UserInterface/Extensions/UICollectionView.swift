//
//  UICollectionView.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import UIKit

extension UICollectionView {

    func register<Cell: UICollectionViewCell>(_: Cell.Type) {
        register(UINib(nibName: Cell.identifier, bundle: nil), forCellWithReuseIdentifier: Cell.identifier)
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath)  -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.identifier)")
        }
        return cell
    }
}
