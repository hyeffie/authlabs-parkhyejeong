//
//  MarkerSelectorButton.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

import UIKit

final class MarkerSelectorButton: UIButton {
    private let size: CGFloat = 54
    private let radius: CGFloat = 12
    
    private let imageCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label.withAlphaComponent(0.7)
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "0"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setInitially()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setInitially() {
        self.backgroundColor = .white.withAlphaComponent(0.3)
        setLayout()
        setRadius()
    }
    
    private func setLayout() {
        self.addSubview(self.imageCountLabel)
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: size),
            self.heightAnchor.constraint(equalToConstant: size),
            self.imageCountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func setRadius() {
        self.layer.cornerRadius = 12
    }
    
    func configure(with count: Int) {
        self.imageCountLabel.text = "\(count)"
    }
    
    func setAction(_ action: UIAction) {
        self.addAction(action, for: .touchUpInside)
    }
}
