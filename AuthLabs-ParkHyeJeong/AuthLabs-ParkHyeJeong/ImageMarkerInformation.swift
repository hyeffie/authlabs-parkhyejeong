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

import UIKit

extension ImageMarkerInformation {
    private var nodeText: String {
        return " \(self.name ?? "name is blank") "
    }
    
    func toImage(ratioReferenceSize size: CGSize) -> UIImage {
        let textSize: CGFloat = 50
        let lineNumber: Int = 20
        let boardHeight = CGFloat(lineNumber) * textSize
        let boardSize = CGSize(height: boardHeight, ratioReferenceSize: size)
        let rect = CGRect(origin: .zero, size: boardSize)
        
        let renderer = UIGraphicsImageRenderer(size: boardSize)
        let image = renderer.image { context in
            let backgroundColor = UIColor.white.withAlphaComponent(0.5)
            backgroundColor.setFill()
            context.fill(rect)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let attributes: [NSAttributedString.Key: Any] = [
                .backgroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: textSize),
                .paragraphStyle: paragraphStyle,
            ]
            
            let attributedText = NSAttributedString(
                string: self.nodeText,
                attributes: attributes
            )
            
            let textColor = UIColor.label
            textColor.setFill()
            attributedText.draw(
                with: rect,
                options: .usesLineFragmentOrigin,
                context: nil
            )
        }
        return image
    }
}
