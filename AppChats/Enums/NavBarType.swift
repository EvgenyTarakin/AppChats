//
//  NavBarType.swift
//  AppChats
//
//  Created by Евгений Таракин on 29.12.2022.
//

import UIKit

//    MARK: - Type
enum NavBarType {
    case chat
    case profile
    
    var font: UIFont {
        switch self {
        case .chat: return AppFont.regular20
        case .profile: return AppFont.bold36
        }
    }
}
