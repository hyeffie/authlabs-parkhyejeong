//
//  ImageMarkerInformation.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/28/24.
//

struct ImageMarkerInformation {
    let identifier: String
    
    let name: String?
    
    let definition: String?
    
    let description: String?
    
    init(
        identifier: String,
        name: String? = nil,
        definition: String? = nil,
        description: String? = nil
    ) {
        self.identifier = identifier
        self.name = name ?? identifier
        self.definition = definition
        self.description = description
    }
}
