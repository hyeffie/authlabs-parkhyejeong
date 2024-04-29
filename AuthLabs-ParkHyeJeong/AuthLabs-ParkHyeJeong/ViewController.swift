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
    
    private let sceneView: ARSCNView
    
    // MARK: - Initializers
    
    init() {
        self.sceneView = .init()
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
        self.view = self.sceneView
        self.sceneView.delegate = self
        self.sceneView.session.delegate = self
        self.sceneView.showsStatistics = true
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
