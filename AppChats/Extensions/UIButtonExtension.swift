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
        self.titleLabel?.font = AppFont.regular20
    }
}
