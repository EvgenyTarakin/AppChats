//
//  UITextFieldExtension.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit

extension UITextField {
    func setTextFieldBorder() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.backgroundColor = .systemGray6
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.setAppCornerRadius()
    }
    
    func setButtonsOnKeyboard() {
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45))
        keyboardToolbar.backgroundColor = .clear
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(closeKeyboard))
        keyboardToolbar.items = [flexBarButton ,closeButton]
        self.inputAccessoryView = keyboardToolbar
    }
    
    @objc private func closeKeyboard() {
        endEditing(true)
    }
}
