//
//  MarkerImage.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

import Foundation

struct MarkerImage: Hashable {
    let imageData: Data
    
    let identifier: UUID
    
    let name: String
    
    let definition: String?
    
    let description: String?
    
    init(
        imageData: Data,
        name: String,
        definition: String? = nil,
        description: String? = nil
    ) {
        self.imageData = imageData
        self.identifier = .init()
        self.name = name
        self.definition = definition
        self.description = description
    }
}
