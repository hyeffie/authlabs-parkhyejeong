//
//  ReusableCell.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

