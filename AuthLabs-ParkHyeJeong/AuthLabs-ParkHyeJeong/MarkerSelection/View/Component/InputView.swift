//
//  InputView.swift
//  AuthLabs-ParkHyeJeong
//
//  Created by Effie on 4/29/24.
//

import UIKit

final class InputView: UIView {
    var currentValue: String {
        return self.textField.text ?? ""
    }
    
    private let fieldNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(self.fieldNameLabel)
        stack.addArrangedSubview(self.textField)
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        fieldName: String
    ) {
        super.init(frame: .zero)
        textField.delegate = self
        configure(fieldName: fieldName)
        setupViews()
    }
    
    private func configure(fieldName: String) {
        self.fieldNameLabel.text = fieldName
    }
    
    private func setupViews() {
        self.addSubview(self.hStack)
        NSLayoutConstraint.activate([
            self.hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.hStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.fieldNameLabel.heightAnchor.constraint(equalTo: self.textField.heightAnchor),
            self.textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
        ])
    }
    
    func configure(with content: String?) {
        self.textField.text = content
    }
}

extension InputView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return true
    }
}
