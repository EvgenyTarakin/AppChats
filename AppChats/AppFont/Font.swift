//
//  Font.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit

private let familyName = "Roboto"

enum Font: String {

    case regular = "Regular"
    case bold = "Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size) {
            return font
        }
        fatalError("Font '\(fullFontName)' does not exist.")
    }
    
    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? familyName : familyName + "-" + rawValue
    }
}
