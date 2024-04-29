//
//  ImageNode.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/28/24.
//

import SceneKit

class PositionableNode: SCNNode {
    func setPosition(x: Float, y: Float, z: Float) {
        self.worldPosition = .init(x: x, y: y, z: z)
    }
}

class ImageNode: PositionableNode {
    init(image: UIImage, size: CGSize) {
        super.init()
        set(image: image, size: size)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set(image: UIImage, size: CGSize) {
        let plane = SCNPlane(width: size.width, height: size.height)
        plane.firstMaterial?.diffuse.contents = image
        self.geometry = plane
        self.eulerAngles.x = -.pi / 2
        self.opacity = 1
    }
}
