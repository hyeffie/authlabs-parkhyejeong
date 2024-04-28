//
//  MarkerInformationView.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/28/24.
//

import UIKit

final class MarkerInformationView: UIView {
    // MARK: - Subviews
    
    private let imageFrame: UIView = {
        let view = UIView()
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()
    
    private let markerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .label
        return label
    }()
    
    init(
        markerIdentifier: String?,
        size: CGSize
    ) {
        super.init(frame: .zero)
        setUp(markerIdentifier: markerIdentifier, size: size)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(
        markerIdentifier: String?,
        size: CGSize
    ) {
        self.markerLabel.text = markerIdentifier
        self.frame.size = size
        setLayout(frameSize: size)
    }
    
    private func setLayout(frameSize: CGSize) {
        self.imageFrame.translatesAutoresizingMaskIntoConstraints = false
        self.markerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.imageFrame)
        self.addSubview(self.markerLabel)
        
        NSLayoutConstraint.activate([
            self.imageFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageFrame.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageFrame.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageFrame.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageFrame.widthAnchor.constraint(equalToConstant: frameSize.width),
            self.imageFrame.heightAnchor.constraint(equalToConstant: frameSize.height),
            self.markerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.markerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}

extension MarkerInformationView {
    func toImage() -> UIImage {
        self.layoutIfNeeded()
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        return renderer.image { context in
            self.layer.render(in: context.cgContext)
        }
    }
}
