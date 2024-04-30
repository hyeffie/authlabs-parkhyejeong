//
//  CGSize+.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

import Foundation

extension CGSize {
    func multiply(_ mutiple: CGFloat) -> Self {
        return .init(
            width: self.width * mutiple,
            height: self.height * mutiple
        )
    }
    
    init(height: CGFloat, ratioReferenceSize size: CGSize) {
        let ratio = size.width / size.height
        let width = height * ratio
        self = .init(width: width, height: height)
    }
}
