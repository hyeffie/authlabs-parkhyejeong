//
//  ImageCollectionContentUnavailableConfiguration.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/30/24.
//

import UIKit

enum ImageCollectionContentUnavailableConfiguration {
    static let noSelectedImage: UIContentUnavailableConfiguration = {
        var config = UIContentUnavailableConfiguration.empty()
        config.text = "선택된 이미지 없음"
        config.secondaryText = "사진 라이브러리에서 마커로 사용할 이미지를 등록해주세요."
        return config
    }()
}
