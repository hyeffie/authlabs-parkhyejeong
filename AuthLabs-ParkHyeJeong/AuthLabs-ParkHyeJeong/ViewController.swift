//
//  ViewController.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/21/24.
//

import ARKit
import SceneKit
import UIKit

final class ViewController: UIViewController {
    private lazy var queue = DispatchQueue(label: .init(describing: self))
    
    // MARK: - Views
    
    private var sceneView: ARSCNView!
    
    private let imageCountButton = MarkerSelectorButton()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSceneView()
        setLayout()
        setButton()
        setIdleTimerAbility()
        runSceneViewSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pauseSceneViewSession()
    }
    
    deinit {
        resetIdleTimerAbility()
    }
}

private extension ViewController {
    func setSceneView() {
        self.sceneView = .init(frame: self.view.frame)
        self.sceneView.delegate = self
        self.sceneView.session.delegate = self
    }
    
    func runSceneViewSession() {
        let referenceGroupName = "Markers"
        guard
            let referenceImages = ARReferenceImage.referenceImages(
                inGroupNamed: referenceGroupName,
                bundle: nil
            )
        else { return }
    
        let arConfiguration = ARWorldTrackingConfiguration()
        arConfiguration.detectionImages = referenceImages
        arConfiguration.maximumNumberOfTrackedImages = 3
        self.sceneView.session.run(
            arConfiguration,
            options: [.resetTracking, .removeExistingAnchors]
        )
    }
    
    func pauseSceneViewSession() {
        self.sceneView.session.pause()
    }
    
    func setIdleTimerAbility() {
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func resetIdleTimerAbility() {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    func setLayout() {
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.sceneView)
        
        NSLayoutConstraint.activate([
            self.sceneView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.sceneView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.sceneView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
            
        self.imageCountButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.imageCountButton)
        
        NSLayoutConstraint.activate([
//            self.imageCountButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
//            self.imageCountButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            
            self.imageCountButton.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 15
            ),
            self.imageCountButton.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                constant: -15
            )
        ])
    }
    
    func setButton() {
        self.imageCountButton.configure(with: 10)
        let action = UIAction { action in
//            let randomNumber = (0...20).randomElement() ?? 0
//            self.imageCountButton.configure(with: randomNumber)
            self.selectImages()
        }
        self.imageCountButton.setAction(action)
    }
    
    func selectImages() {
        let viewController = MarkerSelectionViewController()
        self.present(viewController, animated: true)
    }
}

// MARK: - ARSCNViewDelegate

extension ViewController: ARSCNViewDelegate {
    func renderer(
        _ renderer: any SCNSceneRenderer,
        didAdd node: SCNNode,
        for anchor: ARAnchor
    ) {
        let newNode = makeInfoNode(for: anchor) ?? SCNNode()
        node.addChildNode(newNode)
    }
    
    private func makeInfoNode(for anchor: ARAnchor) -> SCNNode? {
        guard let imageAnchor = anchor as? ARImageAnchor else { return nil }
        let nodeSizeInMeter = imageAnchor.referenceImage.physicalSize
        let nodeSizeTemp = nodeSizeInMeter.multiply(10_000) // CGFloat 자리수 조정 (레퍼런스용)
        let name = imageAnchor.referenceImage.name ?? "undefined"
        let info = ImageMarkerInformation(identifier: name)
        let image = info.toImage(ratioReferenceSize: nodeSizeTemp)
        let informationNode = ImageNode(image: image, size: nodeSizeInMeter)
        return informationNode
    }
}

// MARK: - ARSessionDelegate

extension ViewController: ARSessionDelegate {
    
}
