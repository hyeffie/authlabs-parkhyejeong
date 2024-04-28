//
//  MarkerInformationNode.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/24/24.
//

import SceneKit
import UIKit

final class MarkerInformationNode: SCNNode {
    init(
        markerIdentifier: String,
        size: CGSize
    ) {
        super.init()
        setUp(markerIdentifier: markerIdentifier, size: size)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(
        markerIdentifier: String,
        size: CGSize
    ) {
        self.name = markerIdentifier
        self.eulerAngles.x = .pi * -1 / 2
        let plane = SCNPlane(width: size.width, height : size.height)
        
        Task {
            await MainActor.run {
                let infoView = MarkerInformationView(markerIdentifier: markerIdentifier, size: size)
                let material = SCNMaterial()
                material.diffuse.contents = UIImage(named: "authlabs_logo_door")
                // infoView.toImage() 
                plane.materials = [material]
                self.geometry = plane
            }
        }
    }
}
