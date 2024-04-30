//
//  SelectedImageListDataSource.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

import UIKit

enum SelectedImageListSection {
    case image
}

enum SelectedImageListItem: Hashable {
    case image(imageData: Data)
}

typealias SelectedImageListSnapShot = NSDiffableDataSourceSnapshot<SelectedImageListSection, SelectedImageListItem>

final class SelectedImageListDataSource: UICollectionViewDiffableDataSource<SelectedImageListSection, SelectedImageListItem> {
    typealias CollectionView = ImageCollectionView
    typealias ImageCell = SelectedImageCell
    
    static let cellProvider: CellProvider = { collectionView, indexPath, itemIdentifier in
        switch itemIdentifier {
        case .image(let data):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCell.reuseIdentifier,
                for: indexPath
            ) as? ImageCell else { return UICollectionViewCell() }
            cell.configure(with: data)
            return cell
        }
    }
    
    convenience init(_ listView: CollectionView) {
        self.init(collectionView: listView, cellProvider: Self.cellProvider)
    }
}
