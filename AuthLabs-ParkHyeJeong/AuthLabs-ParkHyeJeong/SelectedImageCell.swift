//
//  SelectedImageCell.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

import UIKit

final class SelectedImageCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    func configure(with imageData: Data) {
        self.imageView.image = UIImage(data: imageData)
    }
}

extension SelectedImageCell: ReusableCell { }
