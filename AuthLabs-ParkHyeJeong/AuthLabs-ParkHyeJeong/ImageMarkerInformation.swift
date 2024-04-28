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
    func toImage(size imageSize: CGSize) -> UIImage {
//        let renderer = UIGraphicsImageRenderer(size: size)
//        let image = renderer.image { context in
//            let rect = CGRect(origin: .zero, size: size)
//            
//            let backgroundColor = UIColor.white.withAlphaComponent(0.5)
//            backgroundColor.setFill()
//            context.fill(rect)
//            
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.alignment = .center
//            paragraphStyle.lineBreakMode = .byWordWrapping
//            
//            let attributes: [NSAttributedString.Key: Any] = [
//                .foregroundColor: UIColor.label,
//                .backgroundColor: UIColor.white,
//                .font: UIFont.systemFont(ofSize: 30),
//                .paragraphStyle: paragraphStyle,
//            ]
//            
//            let attributedText = NSAttributedString(
//                string: self.name ?? "",
//                attributes: attributes
//            )
//            attributedText.draw(
//                with: rect,
//                options: .usesLineFragmentOrigin,
//                context: nil
//            )
//        }
//        return image
        
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let image = renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 30),
                .paragraphStyle: paragraphStyle
            ]
            
            let name = self.name ?? ""
            let attributedText = NSAttributedString(string: name, attributes: attributes)
            attributedText.draw(with: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height), options: .usesLineFragmentOrigin, context: nil)
        }
        return image
    }
}
