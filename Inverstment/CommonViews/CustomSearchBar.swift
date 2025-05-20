//
//  CustomSearchBar.swift
//  Inverstment
//
//  Created by Тася Галкина on 20.05.2025.
//

import UIKit

class CustomSearchBar: UIView {
    
    private let textField = UITextField()
    private let leftArrow = UIImageView()
    private let clearButton = UIButton(type: .system)
    
    var onTextChange: ((String?) -> Void)?
    var onClear: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        setUpTextField()
        setUpleftArrow()
        setUpClearButton()
    }
    
    private func setUpTextField() {
        addSubview(textField)
        
        textField.borderStyle = .none
        textField.placeholder = "Find company or ticker"
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blackColor.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        textField.leftViewMode = .always
        textField.rightViewMode = .whileEditing
        textField.returnKeyType = .search
        textField.font = UIFont(name: Constants.semiBoldFont, size: Constants.semiBoldFontSize)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpleftArrow() {
        textField.addSubview(leftArrow)
        
        leftArrow.image = UIImage(named: "Search")
        leftArrow.contentMode = .center
        
        leftArrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftArrow.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 10),
            leftArrow.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            leftArrow.widthAnchor.constraint(equalToConstant: 20),
            leftArrow.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setUpClearButton() {
        textField.addSubview(clearButton)
        
        clearButton.setImage(UIImage(named: "Close"), for: .normal)
        clearButton.tintColor = .blackColor
        clearButton.isHidden = true
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            clearButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -10),
            clearButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 20),
            clearButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc private func textDidChange() {
        updateState(isEditing: true, text: textField.text)
        onTextChange?(textField.text)
    }
    
    @objc private func clearButtonTapped() {
        textField.text = ""
        updateState(isEditing: false, text: nil)
        onClear?()
    }
    
    func updateState(isEditing: Bool, text: String?) {
        leftArrow.image = UIImage(named: (!isEditing && ((text?.isEmpty) != nil)) ? "Search" : "Back")
        clearButton.isHidden = text?.isEmpty ?? true
    }
}

extension CustomSearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateState(isEditing: true, text: textField.text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateState(isEditing: false, text: textField.text)
    }
}
