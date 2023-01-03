//
//  UILabelExtension.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit

extension UILabel {
    func setTitleLabel(_ title: String) {
        self.text = title
        self.textColor = .black
        self.textAlignment = .left
    }
    
    func setDescriptionLabel(_ text: String) {
        self.font = AppFont.regular16
        self.text = text
        self.textColor = .lightGray
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
    }
    
    func setStandartLabel(_ text: String) {
        self.text = text
        self.font = AppFont.regular20
        self.textColor = .black
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
    }
    
    func setStandartBoldLabel(_ text: String) {
        self.text = text
        self.font = AppFont.bold20
        self.textColor = .black
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
    }
    
    func setErrorLabel(_ text: String) {
        self.text = text
        self.font = AppFont.bold20
        self.textColor = .systemRed
        self.textAlignment = .center
        self.adjustsFontSizeToFitWidth = true
    }
}
