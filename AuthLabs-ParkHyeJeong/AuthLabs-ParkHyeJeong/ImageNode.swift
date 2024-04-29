//
//  ImageNode.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/28/24.
//

import SceneKit

final class ImageNode: SCNNode {
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
