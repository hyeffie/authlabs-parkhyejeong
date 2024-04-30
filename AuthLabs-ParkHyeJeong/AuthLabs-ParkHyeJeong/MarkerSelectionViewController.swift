//
//  MarkerSelectionViewController.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

import UIKit

final class MarkerSelectionViewController: UIViewController {
    
    private var currentImageID: Int?
    
    private lazy var imageCollectionDataSource: SelectedImageListDataSource = .init(self.collectionView)
    
    private let collectionView: ImageCollectionView = {
        let collectionView = ImageCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let nameField = InputView(fieldName: "이름")
    
    private let definitionField = InputView(fieldName: "정의")
    
    private let descriptionField = InputView(fieldName: "설명")
    
    private lazy var fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(self.nameField)
        stack.addArrangedSubview(self.definitionField)
        stack.addArrangedSubview(self.descriptionField)
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        updateCollectionView()
    }
    
    private func setView() {
        self.view.backgroundColor = .systemBackground
        self.title = "마커 추가"
        setLayout()
    }

    private func setLayout() {
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.fieldStack)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            
            self.fieldStack.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 12),
            self.fieldStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.fieldStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    private func configureFields(with marker: MarkerImage) {
        self.nameField.configure(with: marker.name)
        self.definitionField.configure(with: marker.definition)
        self.descriptionField.configure(with: marker.description)
    }
    
    private func updateCollectionView() {
        let dataArr = [
            "imac-21",
            "macbookpro-13",
            "QR-github-hyeffie",
        ].map { name in UIImage(named: name)!.pngData()! }
        
        var snapshot = SelectedImageListSnapShot()
        snapshot.appendSections([.image])
        let items = dataArr.map { data in SelectedImageListItem.image(imageData: data) }
        snapshot.appendItems(items, toSection: .image)
        
        self.imageCollectionDataSource.apply(snapshot)
    }
}
