//
//  MarkerSelectionViewController.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

import UIKit
import PhotosUI

final class MarkerSelectionViewController: UIViewController {
    enum ListState {
        case noSelectedImage
        case noProblem
    }
    
    private var currentImage: MarkerImage? {
        didSet {
            configureFields(with: self.currentImage)
        }
    }
    
    private var selection = [String: PHPickerResult]() {
        didSet {
            updateLoadedImages()
        }
    }
    
    private var loadedImages: [LoadedImage] = [] {
        didSet {
            updateCollection()
        }
    }
    
    private var listState: ListState = .noSelectedImage {
        didSet {
            updateListState()
        }
    }
    
    private var imagePicker: PHPickerViewController?
    
    private lazy var imageCollectionDataSource = SelectedImageListDataSource(self.collectionView)
    
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
    
    private lazy var noSelectedImageConfiguration: UIContentUnavailableConfiguration = {
        var config = UIContentUnavailableConfiguration.empty()
        config.text = "선택된 이미지 없음"
        config.secondaryText = "사진 라이브러리에서 마커로 사용할 이미지를 선택해주세요."
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.title = "사진 선택"
        config.button = buttonConfig
        config.buttonProperties.primaryAction = UIAction { _ in
            self.presentPicker()
        }
        return config
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
        updateCollection()
    }
    
    override func updateContentUnavailableConfiguration(
        using state: UIContentUnavailableConfigurationState
    ) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            switch self.listState {
            case .noSelectedImage:
                let config = self.noSelectedImageConfiguration
                self.contentUnavailableConfiguration = config
            case .noProblem:
                self.contentUnavailableConfiguration = nil
            }
        }
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
    
    private func configureFields(with marker: MarkerImage?) {
        guard let marker else {
            return
        }
        self.nameField.configure(with: marker.name)
        self.definitionField.configure(with: marker.definition)
        self.descriptionField.configure(with: marker.description)
    }
    
    private func updateLoadedImages() {
        self.selection.forEach { (identifier, result) in
            let provider = result.itemProvider
            guard provider.canLoadObject(ofClass: UIImage.self) else {
                return
            }
            _ = provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                if let error {
                    return
                }
                guard let image = image as? UIImage else {
                    return
                }
                let loadedImage = LoadedImage(image: image, identifier: identifier)
                self?.loadedImages.append(loadedImage)
            }
        }
    }
    
    private func updateCollectionView() {
        let imageNames = [
            "imac-21",
            "macbookpro-13",
            "QR-github-hyeffie",
        ]
        
        var snapshot = SelectedImageListSnapShot()
        snapshot.appendSections([.image])
        let items = imageNames.map { name in
            let image = UIImage(named: name)!
            let loadedImage = LoadedImage(image: image, identifier: name)
            return SelectedImageListItem.image(loadedImage)
        }
        snapshot.appendItems(items, toSection: .image)
        
        self.imageCollectionDataSource.apply(snapshot)
        
        self.listState = items.isEmpty ? .noSelectedImage : .noProblem
    }
    
    private func updateCollection() {
        var snapshot = SelectedImageListSnapShot()
        snapshot.appendSections([.image])
        
        let items = self.loadedImages.map { SelectedImageListItem.image($0) }
        snapshot.appendItems(items, toSection: .image)
        self.imageCollectionDataSource.apply(snapshot)
        
        self.listState = items.isEmpty ? .noSelectedImage : .noProblem
    }
    
    private func updateListState() {
        Task {
            await MainActor.run {
                setNeedsUpdateContentUnavailableConfiguration()
                self.fieldStack.isHidden = self.listState == .noSelectedImage
            }
        }
    }
}

// MARK: - PHPickerViewControllerDelegate Implements

extension MarkerSelectionViewController: PHPickerViewControllerDelegate {
    func picker(
        _ picker: PHPickerViewController, 
        didFinishPicking results: [PHPickerResult]
    ) {
        dismiss(animated: true)
        
        let existingSelection = self.selection
        var newSelection = [String: PHPickerResult]()
        for result in results {
            let identifier = result.assetIdentifier!
            newSelection[identifier] = existingSelection[identifier] ?? result
        }
        
        // Track the selection in case the user deselects it later.
        selection = newSelection
        
//        selectedAssetIdentifiers = results.map(\.assetIdentifier!)
//        selectedAssetIdentifierIterator = selectedAssetIdentifiers.makeIterator()
    }
    
    private func presentPicker() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.preferredAssetRepresentationMode = .current
        configuration.selection = .ordered
        configuration.selectionLimit = 3
//        configuration.preselectedAssetIdentifiers = selectedAssetIdentifiers
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        if self.loadedImages.isEmpty == false {
            loadedImages.removeAll()
        }
        present(picker, animated: true)
    }
}
