//
//  UICollectionView+.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

import UIKit

extension UICollectionView {
    func register<Cell: ReusableCell & AnyObject>(_ cellType: Cell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
}
