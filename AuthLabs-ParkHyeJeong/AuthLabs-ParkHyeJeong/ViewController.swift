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
        let newNode = makeNode(for: anchor) ?? SCNNode()
        node.addChildNode(newNode)
    }
    
    private func makeInfoNode(for anchor: ARAnchor) -> SCNNode? {
        if let imageAnchor = anchor as? ARImageAnchor {
            let nodeSize = imageAnchor.referenceImage.physicalSize
            let imageName = imageAnchor.name ?? "undefined"
            let info = ImageMarkerInformation(identifier: imageName)
            let image = info.toImage(size: nodeSize)
            let informationNode = ImageNode(image: image, size: nodeSize)
            return informationNode
        }
        return nil
    }
    
    private func makeNode(for anchor: ARAnchor) -> SCNNode? {
        if
            let imageAnchor = anchor as? ARImageAnchor
        {
            let plane = SCNPlane(
                width: imageAnchor.referenceImage.physicalSize.width,
                height: imageAnchor.referenceImage.physicalSize.height
            )
            let planeNode = SCNNode(geometry: plane)

            planeNode.opacity = 0.5
            planeNode.eulerAngles.x = -.pi / 2
            planeNode.name = imageAnchor.referenceImage.name
            
            return planeNode
        }
        return nil
    }
}

// MARK: - ARSessionDelegate

extension ViewController: ARSessionDelegate {
    
}
