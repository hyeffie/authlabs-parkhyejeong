//
//  LoadedImage.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/30/24.
//

import UIKit

struct LoadedImage: Hashable {
    let image: UIImage
    
    let identifier: String
    
    init(image: UIImage, identifier: String) {
        self.image = image
        self.identifier = identifier
    }
}
