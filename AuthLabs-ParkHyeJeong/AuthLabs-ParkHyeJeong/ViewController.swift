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
    // MARK: - Outlets
    
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - View Life cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        runSceneViewSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        pauseSceneViewSession()
    }
}

private extension ViewController {
    func setSceneView() {
        self.sceneView.delegate = self
        self.sceneView.showsStatistics = true
        
        let textureResourceName = "art.scnassets/ship.scn"
        guard let scene = SCNScene(named: textureResourceName) else { return }
        self.sceneView.scene = scene
    }
    
    func runSceneViewSession() {
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.session.run(configuration)
    }
    
    func pauseSceneViewSession() {
        self.sceneView.session.pause()
    }
}

// MARK: - ARSCNViewDelegate

extension ViewController: ARSCNViewDelegate {
    func renderer(
        _ renderer: SCNSceneRenderer,
        nodeFor anchor: ARAnchor
    ) -> SCNNode? {
        let node = SCNNode()
        return node
    }
}
