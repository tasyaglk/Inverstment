//
//  CustomSearchBar.swift
//  Inverstment
//
//  Created by Тася Галкина on 20.05.2025.
//

import UIKit

final class CustomSearchBar: UIView {
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = Constants.searchBarCornerRadius
        textField.layer.borderWidth = Constants.searchBarBorderWidth
        textField.layer.borderColor = UIColor.blackColor.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.searchBarLeftPadding, height: 0))
        textField.leftViewMode = .always
        textField.rightViewMode = .whileEditing
        textField.returnKeyType = .search
        textField.font = UIFont(name: Constants.semiBoldFont, size: Constants.semiBoldFontSize)
        textField.textColor = .blackColor
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blackColor,
            .font: UIFont(name: Constants.semiBoldFont, size: Constants.semiBoldFontSize) ?? .systemFont(ofSize: Constants.semiBoldFontSize)
        ]
        
        textField.attributedPlaceholder = NSAttributedString(
            string: Constants.searchBarPlaceholderText,
            attributes: placeholderAttributes
        )
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        return textField
    }()
    
    private let leftArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.searchBarSearchIconName)
        imageView.contentMode = .center
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let clearButton: UIButton = {
        let clearButton = UIButton(type: .system)
        clearButton.setImage(UIImage(named: Constants.searchBarClearIconName), for: .normal)
        clearButton.tintColor = .blackColor
        clearButton.isHidden = true
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        return clearButton
    }()
    
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
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpleftArrow() {
        textField.addSubview(leftArrow)
        
        NSLayoutConstraint.activate([
            leftArrow.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: Constants.searchBarIconLeadingPadding),
            leftArrow.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            leftArrow.widthAnchor.constraint(equalToConstant: Constants.searchBarIconSize),
            leftArrow.heightAnchor.constraint(equalToConstant: Constants.searchBarIconSize)
        ])
    }
    
    private func setUpClearButton() {
        addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            clearButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Constants.searchBarClearButtonTrailingPadding),
            clearButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: Constants.searchBarIconSize),
            clearButton.heightAnchor.constraint(equalToConstant: Constants.searchBarIconSize)
        ])
    }
    
    @objc private func textDidChange() {
        textField.attributedPlaceholder = nil
        updateState(isEditing: true, text: textField.text)
        onTextChange?(textField.text)
    }
    
    @objc private func clearButtonTapped() {
        textField.text = ""
        updateState(isEditing: false, text: nil)
        onClear?()
    }
    
    func updateState(isEditing: Bool, text: String?) {
        leftArrow.image = UIImage(named: (!isEditing && ((text?.isEmpty) != nil)) ? Constants.searchBarSearchIconName : Constants.searchBarBackIconName)
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
