//
//  SCNMaterial+UIImage.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/28/24.
//

import SceneKit

extension SCNMaterial {
    convenience init(image: UIImage) {
        self.init()
        self.diffuse.contents = [image]
        self.isDoubleSided = true
    }
}
