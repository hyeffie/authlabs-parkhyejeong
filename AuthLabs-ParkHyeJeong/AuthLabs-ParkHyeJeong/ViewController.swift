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
    
    override func loadView() {
        super.loadView()
    }
    
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
        self.sceneView.session.run(arConfiguration)
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
        _ renderer: SCNSceneRenderer,
        nodeFor anchor: ARAnchor
    ) -> SCNNode? {
        return nil
    }
}

// MARK: - ARSessionDelegate

extension ViewController: ARSessionDelegate {
    
}
