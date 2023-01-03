//
//  UIButtonExtension.swift
//  AppChats
//
//  Created by Евгений Таракин on 23.12.2022.
//

import UIKit

extension UIButton {
    func setEnterButton(_ text: String) {
        self.backgroundColor = .blue
        self.setAppCornerRadius()
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = AppFont.regular20
    }
    
    func setEditActiveButton() {
        self.backgroundColor = .white
        self.setAppCornerRadius()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
        self.setTitle("Готово", for: .normal)
        self.setTitleColor(.blue, for: .normal)
        self.titleLabel?.font = AppFont.regular20
    }
}
